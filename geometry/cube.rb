module RubyRay
  class Cube
    attr_accessor :width, :height, :depth

    def initialize(width: 1, height: 1, depth: 1)
      @width = width
      @height = height
      @depth = depth
    end
  end
end
