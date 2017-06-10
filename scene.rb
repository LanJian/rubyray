module RubyRay
  class Scene
    def initialize(camera:, background: ChunkyPNG::Color(:black))
      @camera = camera
      @background = background
      @objects = []
      @lights = []
    end

    def render(width:, height:)
      # generate rays

      # distance from camera to screen
      d = height / 2.0 / Math.tan(@camera.fov / 2.0)

      png = ChunkyPNG::Image.new(width, height, @background)

      width.times do |u|
        height.times do |v|
          # generate rays
          ray_vector =
            @camera.view * d +
            @camera.up * (height / 2.0 - v) +
            @camera.side * (u - width / 2.0)
          ray = Ray.new(position: @camera.p, direction: ray_vector.normalize)

          results = @objects.map { |o| [o, ray.intersection(o)] }
                            .reject { |a| a[1].nil? }
          next if results.empty?

          closest = results.min do |a, b|
            a[1][:nearest][:distance] <=> b[1][:nearest][:distance]
          end

          n = closest[1][:nearest][:normal]
          t = closest[1][:nearest][:distance]
          p = closest[1][:nearest][:point]
          vv = -ray_vector.normalize

          i = Color::BLACK
          @lights.each do |light|
            o = closest[0]
            m = o.material
            ka = m.ambient
            kd = m.diffuse
            ks = m.specular
            a = m.shininess

            ia = light.a
            id = light.d
            is = light.s

            l = (light.p - p).normalize
            r = 2 * (l * n) * n - l

            i += ka * ia
            i += kd * (l * n) * id if (l * n).positive?
            i += ks * (r * vv)**a * is if (r * vv).positive?
          end

          png[u, v] = ChunkyPNG::Color.rgba(
            i.r.to_i, i.g.to_i, i.b.to_i, 255
          )
        end
      end

      png.save('output.png')
    end

    def add_object(object)
      @objects.push(object)
    end

    def add_light(light)
      @lights.push(light)
    end
  end
end
