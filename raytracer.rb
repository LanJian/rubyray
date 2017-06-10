$LOAD_PATH.unshift(File.expand_path(__dir__))

Bundler.require

require 'phong'
require 'algebra'
require 'camera'
require 'geometry'
require 'scene'
require 'color'
require 'light'

module RubyRay
  def self.raytrace
    camera = Camera.new(
      position: Vector::ZERO,
      view: Vector::K,
      up: Vector::J,
      fov: Math::PI / 2
    )

    scene = Scene.new(camera: camera)
    
    # lights
    scene.add_light(
      Light.new(
        position: Vector[10, 5, 0],
        ambient: Color::WHITE * 0.1,
        diffuse: Color::WHITE,
        specular: Color::WHITE
      )
    )

    # shit to render
    scene.add_object(
      Sphere.new(
        centre: Vector[0, 0, 5],
        radius: 2,
        material: Phong.new(
          ambient: Color::RED,
          diffuse: Color::RED,
          specular: Color::WHITE,
          shininess: 20
        )
      )
    )
    scene.add_object(
      Sphere.new(
        centre: Vector[4, 4, 10],
        radius: 2,
        material: Phong.new(
          ambient: Color::BLUE,
          diffuse: Color::BLUE,
          specular: Color::WHITE,
          shininess: 20
        )
      )
    )
    scene.render(width: 1280, height: 720)
  end

  if $PROGRAM_NAME == __FILE__
    raytrace
  end
end
