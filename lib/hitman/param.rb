module Hitman
  class Param
    attr_accessor :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    def to_s
      "#{name}: #{type}"
    end
  end
end
