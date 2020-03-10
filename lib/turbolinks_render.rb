require 'turbolinks_render/version'
require 'turbolinks_render/rendering'
require 'turbolinks_render/middleware'
require 'turbolinks_render/debug_exceptions_patch'

module TurbolinksRender
  class TurbolinksRenderMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @status, @headers, @response = @app.call(env)
    end
  end

  class Engine < ::Rails::Railtie
    config.turbolinks_render = ActiveSupport::OrderedOptions.new
    config.turbolinks_render.render_with_turbolinks_by_default = true
    config.turbolinks_render.ignored_paths = []

    initializer :turbolinks_render do |app|
      app.config.app_middleware.insert_before ActionDispatch::ShowExceptions, TurbolinksRender::Middleware

      ActiveSupport.on_load(:action_controller) do
        include Rendering
      end

      class ActionDispatch::DebugExceptions
        prepend DebugExceptionsPatch
      end
    end
  end
end
