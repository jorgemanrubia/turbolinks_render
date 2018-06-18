require 'turbolinks_render/version'
require 'turbolinks_render/rendering'

module TurbolinksRender
  class Engine < ::Rails::Railtie
    config.turbolinks_render = ActiveSupport::OrderedOptions.new
    config.turbolinks_render.render_with_turbolinks_by_default = true

    initializer :turbolinks_render do |app|
      ActiveSupport.on_load(:action_controller) do
        include Rendering
      end
    end
  end
end

