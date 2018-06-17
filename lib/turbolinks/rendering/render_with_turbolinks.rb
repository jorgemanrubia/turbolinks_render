module Turbolinks
  module Rendering
    module RenderWithTurbolinks
      def render(*args, &block)
        if request.xhr? && !request.get?
          render_with_turbolinks(*args, &block)
        else
          super
        end
      end

      private

      def render_with_turbolinks(*args, &block)
        html = render_to_string(*args, &block)
        self.response_body = turbolinks_response_to_render(html)
        self.status = 200
        response.content_type = 'text/javascript'
      end

      def turbolinks_response_to_render(html)
        escaped_html = ActionController::Base.helpers.j(html)

        <<-JS
    (function(){
      Turbolinks.clearCache();
      var parser = new DOMParser();
      var newDocument = parser.parseFromString("#{escaped_html}", "text/html");

      document.documentElement.replaceChild(newDocument.body, document.body);
      Turbolinks.dispatch('turbolinks:load');
      window.scroll(0, 0);
    })();
        JS
      end
    end
  end
end

AbstractController::Rendering.prepend(Turbolinks::Rendering::RenderWithTurbolinks)
