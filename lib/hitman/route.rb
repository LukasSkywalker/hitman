module Hitman
  class Route
    attr_accessor :method, :path, :params

    def initialize(method, path)
      @method = method
      @path = path
      @params = []
    end

    def url
      path
    end

    def to_s
      "#{method.ljust(10)} #{url.ljust(20)} #{params.join(', ')}"
    end
  end
end
