require "hitman/version"
require "hitman/fuzzer"

module Hitman
  class Scanner
    def scan_grape(target, klass)

      klass.routes.each do |api|
        route = Hitman::Route.new(api.route_method, api.route_path.split("\(").first)
        target.routes << route
        api.route_params.each do |name, details|
          route.params << Hitman::Param.new(name, details[:type])
        end
      end
      target

    end

    def scan_rails(target, klass)
      Rails.application.routes.routes.to_a.each do |route|
        name = route.name
        path = route.path.spec.to_s.split('\(').first
        method = route.constraints[:request_method]
      end
    end
  end
end
