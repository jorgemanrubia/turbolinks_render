module TurbolinksRender
  module Rendering
    extend ActiveSupport::Concern

    def render(*args, &block)
      options = args.dup.extract_options!
      capture_turbolinks_option_to_make_it_accessible_by_middleware(options)
      super
    end

    private

    def capture_turbolinks_option_to_make_it_accessible_by_middleware(options)
      request.set_header('X-Turbolinks-Render-Option', options[:turbolinks])
    end
  end
end
