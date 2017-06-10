module RubyRay
  class Phong
    attr_reader :ambient, :diffuse, :specular, :shininess

    def initialize(ambient:, diffuse:, specular:, shininess:)
      @ambient = ambient
      @diffuse = diffuse
      @specular = specular
      @shininess = shininess
    end
  end
end
