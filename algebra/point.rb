module RubyRay
  class Point
    attr_reader :elements

    # Creates a point
    #
    # @param elements [Array<Numeric>] The elements of the point
    def initialize(*elements)
      @elements = elements
    end

    # Creates a point
    #
    # @param elements [Array<Numeric>] The elements of the point
    def self.[](*elements)
      new(*elements)
    end

    # Convenience points
    ORIGIN = new(0, 0, 0)

    # Translates the point by adding a vector to this point
    #
    # @param other [RubyRay::Vector] The vector to add
    # @return [RubyRay::Point] The result point
    def +(vector)
      Point.new(*@elements.zip(vector.elements).map { |a, b| a + b })
    end

    # Given a vector, translates the point by subtracting a vector from this
    #   point
    # Given a point, returns the vector from the given point to this point
    #
    # @param other [RubyRay::Vector, RubyRay::Point] The vector or point to
    #   subtract
    # @return [RubyRay::Vector, RubyRay::Point] The result vector or point
    def -(other)
      if other.is_a?(Vector)
        return Point.new(*@elements.zip(other.elements).map { |a, b| a - b })
      end

      Vector.new(*@elements.zip(other.elements).map { |a, b| a - b })
    end

    # Returns the string representation of the point
    #
    # @return [String] The string representation of the point
    def to_s
      "(#{@elements.join(', ')})"
    end
  end
end
