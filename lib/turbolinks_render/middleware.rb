module TurbolinksRender
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @request = Rack::Request.new(env)
      @status, @headers, @response = @app.call(env)
      body = @response.body
      if render_with_turbolinks?
        body = build_turbolinks_response_to_render(@response.body)
        @headers["Content-Type"] = 'text/javascript'
      end
      [@status, @headers, [body]]
    end

    private

    def render_with_turbolinks?
      turbolinks_response_candidate?  && (turbolinks_render_option || (render_with_turbolinks_by_default? && turbolinks_render_option != false))
    end

    def turbolinks_render_option
      @request.get_header('X-Turbolinks-Render-Option')
    end

    def turbolinks_response_candidate?
      @request.xhr? && !@request.get? && html_response?
    end

    def html_response?
      @headers['Content-Type'] =~ /text\/html/
    end

    def build_turbolinks_response_to_render(html)
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

    def render_with_turbolinks_by_default?
      Rails.application.config.turbolinks_render.render_with_turbolinks_by_default
    end

  end
end
