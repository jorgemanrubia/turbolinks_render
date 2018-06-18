require 'turbolinks_rails_render/version'
require 'turbolinks_rails_render/rendering'

module TurbolinksRailsRender
  class Engine < ::Rails::Railtie
    config.turbolinks_render = ActiveSupport::OrderedOptions.new
    config.turbolinks_render.render_with_turbolinks_by_default = true

    initializer :turbolinks_rails_render do |app|
      ActiveSupport.on_load(:action_controller) do
        if app.config.turbolinks.auto_include
          include Rendering
        end
      end
    end
  end
end

