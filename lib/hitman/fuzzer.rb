require 'net/http'

require_relative 'target'
require_relative 'route'
require_relative 'param'
require_relative 'request'

dir = File.dirname(File.dirname(__FILE__))

Dir.glob(dir + '/hitman/iterators/*.rb') do |f|
  require_relative f
end

module Hitman
  class Fuzzer
    def add_param(url, param_name, param_value)
      uri = URI(url)
      params = URI.decode_www_form(uri.query || []) << [param_name, param_value]
      uri.query = URI.encode_www_form(params)
      uri.to_s
    end

    def start(t)
      puts t
      puts ""

      t.routes.each do |route|
        url = t.host + t.prefix + route.url
        puts "Checking #{url}"
        iterators = []
        total_iterations = 1
        route.params.each do |param|
          iterator = Kernel.const_get(param.type + 'Iterator').new.get
          iterators << iterator
          total_iterations *= iterator.length
        end
        next if iterators.empty?
        iterations = iterators.first.product(*iterators[1..-1]) #splat == #swag

        puts "Total iterations: #{total_iterations}"

        iterations.each do |iteration|
          uri = URI(url)
          params = {}

          route.params.each_with_index do |param, i|
            params[param.name] = iteration[i]
          end

          if route.method.downcase == 'get'
            uri.query = URI.encode_www_form(params.merge t.postfix)
            res = Hitman::Request.get(uri)
          else
            uri.query = URI.encode_www_form(t.postfix)
            payload = params.to_json
            res = Hitman::Request.post(uri, payload)
          end
          if res.code.to_i >= 500 && res.code.to_i <= 599
            puts "Yay, fu**ed!"
            puts "URL: #{route.method} #{uri}"
            puts "Params: #{params.inspect}"
            puts "Continue?"
            gets
          end

        end
      end
    end
  end
end
