module RubyRay
  class Vector
    attr_reader :elements

    # Creates a vector
    #
    # @param elements [Array<Numeric>] The elements of the vector
    def initialize(*elements)
      @elements = elements
    end

    # Creates a vector
    #
    # @param elements [Array<Numeric>] The elements of the vector
    def self.[](*elements)
      new(*elements)
    end

    # Convenience vectors
    ZERO = new(0, 0, 0)
    I = new(1, 0, 0)
    J = new(0, 1, 0)
    K = new(0, 0, 1)

    # Adds another vector to this vector
    #
    # @param other [RubyRay::Vector] The other vector
    # @return [RubyRay::Vector] The result vector
    def +(other)
      Vector.new(*@elements.zip(other.elements).map { |a, b| a + b })
    end

    # Subtracts another vector from this vector
    #
    # @param other [RubyRay::Vector] The other vector
    # @return [RubyRay::Vector] The result vector
    def -(other)
      Vector.new(*@elements.zip(other.elements).map { |a, b| a - b })
    end

    # If given a scalar, multiplies this vector by the scalar.
    # If given a vector, returns the dot product of the two vectors
    #
    # @param other [RubyRay::Vector, Numeric] The other vector or scalar
    # @return [RubyRay::Vector, Numeric] If given a scalar, returns the result
    #   vector. If given a vector, returns the result scalar
    def *(other)
      return Vector.new(*@elements.map { |e| e * other }) if other.is_a? Numeric
      @elements.zip(other.elements).map { |a, b| a * b }.reduce(&:+)
    end

    def -@
      ZERO - self
    end

    # Given a vector, returns the cross product of the two vectors
    #
    # @param other [RubyRay::Vector] The other vector
    def cross(other)
      # only defined in R^3
      u1, u2, u3 = @elements[0...3]
      v1, v2, v3 = other.elements[0...3]
      Vector.new(u2 * v3 - u3 * v2, u3 * v1 - u1 * v3, u1 * v2 - u2 * v1)
    end

    def coerce(other)
      [self, other]
    end

    # Returns the magnitude of the vector
    #
    # @return [Numeric] The maginitude of the vector
    def magnitude
      Math.sqrt(elements.reduce(0) { |a, e| a + e * e })
    end

    # Returns the normalized vector
    #
    # @return [RubyRay::Vector] The normalized vector
    def normalize
      Vector.new(*@elements.map { |e| e.to_f / magnitude })
    end

    # Returns the string representation of the vector
    #
    # @return [String] The string representation of the vector
    def to_s
      "(#{@elements.join(', ')})"
    end
  end
end
