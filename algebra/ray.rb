module RubyRay
  class Ray
    attr_reader :position, :direction
    alias p position
    alias d direction

    # Creates a ray
    #
    # @param position [RubyRay::Point] The starting position of the ray
    # @param elements [RubyRay::Vector] The direction of the ray
    def initialize(position:, direction:)
      @position = position
      @direction = direction
    end

    def point_along(distance)
      p + distance * d
    end

    # Returns the string representation of the ray
    #
    # @return [String] The string representation of the ray
    def to_s
      "p: #{p}, d: #{d}"
    end

    def intersection(object)
      return false unless object.respond_to?(:intersection)
      object.intersection(self)
    end
  end
end
