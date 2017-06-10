module RubyRay
  # Point light
  class Light
    attr_reader :position, :ambient, :diffuse, :specular
    alias p position
    alias a ambient
    alias d diffuse
    alias s specular

    def initialize(position:, ambient:, diffuse:, specular:)
      @position = position
      @ambient = ambient
      @diffuse = diffuse
      @specular = specular
    end
  end
end
