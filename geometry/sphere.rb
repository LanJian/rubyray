module RubyRay
  class Sphere
    attr_reader :material

    def initialize(centre: Vector::ZERO, radius: 1, material: nil)
      @centre = centre
      @radius = radius
      @material = material
    end

    def intersection(ray)
      l = ray.direction
      o = ray.position
      r = @radius
      c = @centre

      d1 = -(l * (o - c)) +
        Math.sqrt((l * (o - c))**2 - (o - c).magnitude**2 + r**2)
      d2 = -(l * (o - c)) -
        Math.sqrt((l * (o - c))**2 - (o - c).magnitude**2 + r**2)

      solutions = [d1, d2].uniq.reject { |e| e <= 0 }

      {
        nearest: {
          distance: solutions.min,
          point: ray.point_along(solutions.min),
          normal: normal(ray.point_along(solutions.min))
        },
        intersections: solutions.map do |s|
          {
            distance: s,
            point: ray.point_along(s),
            normal: normal(ray.point_along(s))
          }
        end
      }
    rescue Math::DomainError
      nil
    end

    def normal(point)
      (point - @centre).normalize
    end
  end
end
