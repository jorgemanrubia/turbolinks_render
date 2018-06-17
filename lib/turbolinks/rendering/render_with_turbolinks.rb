module Turbolinks
  module Rendering
    module RenderWithTurbolinks
      def render(*args, &block)
        puts "intercepted"
        super
      end
    end
  end
end

AbstractController::Rendering.prepend(Turbolinks::Rendering::RenderWithTurbolinks)
