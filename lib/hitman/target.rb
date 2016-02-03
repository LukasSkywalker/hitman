module Hitman
  class Target
    attr_accessor :name, :host, :routes, :prefix, :postfix

    def initialize(name, host)
      @name = name
      @host = host
      @prefix = ''
      @postfix = ''
      @routes = []
    end

    def to_s
      "Analysis for #{name}\n" +
      "-------------" + "-" * name.length + "\n" +
      routes.join("\n")
    end
  end
end
