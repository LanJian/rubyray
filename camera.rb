module RubyRay
  class Camera
    attr_reader :position, :view, :up, :side, :fov
    alias p position

    def initialize(position:, view:, up:, fov:)
      @position = position
      @view = view
      @up = up
      @fov = fov

      @side = up.cross(view)
    end
  end
end
