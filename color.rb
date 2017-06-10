module RubyRay
  class Color
    attr_reader :r, :g, :b

    def initialize(r:, g:, b:)
      @r = r
      @g = g
      @b = b
      clamp
    end

    def clamp
      @r = [[@r, 0].max, 255].min
      @g = [[@g, 0].max, 255].min
      @b = [[@b, 0].max, 255].min
    end

    WHITE = new(r: 255, g: 255, b: 255)
    BLACK = new(r: 0, g: 0, b: 0)
    RED = new(r: 255, g: 0, b: 0)
    GREEN = new(r: 0, g: 255, b: 0)
    BLUE = new(r: 0, g: 0, b: 255)

    def +(other)
      Color.new(
        r: @r + other.r,
        g: @g + other.g,
        b: @b + other.b
      )
    end

    def *(other)
      if other.is_a?(Numeric)
        return Color.new(
          r: @r * other,
          g: @g * other,
          b: @b * other
        )
      end

      Color.new(
        r: @r * other.r / 255.0,
        g: @g * other.g / 255.0,
        b: @b * other.b / 255.0
      )
    end

    def coerce(other)
      [self, other]
    end

    def to_s
      "(r: #{r}, g: #{g}, b: #{b})"
    end
  end
end
