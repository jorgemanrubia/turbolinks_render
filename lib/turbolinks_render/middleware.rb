module TurbolinksRender
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @request = Rack::Request.new(env)
      @request.set_header('X-Turbolinks-Render-Candidate', request_candidate_for_turbolinks?)

      @status, @headers, @response = @app.call(env)

      return [@status, @headers, @response] unless render_with_turbolinks?

      body = ''
      @response.each{|part| body << part}
      body = render_body_with_turbolinks(body)
      [@status, @headers, [body]]
    end

    private

    def render_body_with_turbolinks(body)
      @headers["Content-Type"] = 'text/javascript'
      build_turbolinks_response_to_render(body).tap do |turbolinks_body|
        @headers["Content-Length"] = turbolinks_body.bytesize
      end
    end

    def render_with_turbolinks?
      request_candidate_for_turbolinks? && response_candidate_for_turbolinks? &&
          (turbolinks_render_option || (render_with_turbolinks_by_default? && turbolinks_render_option != false))
    end

    def response_candidate_for_turbolinks?
      html_response?
    end

    def turbolinks_render_option
      @request.get_header('X-Turbolinks-Render-Option')
    end

    def request_candidate_for_turbolinks?
      @request.xhr? && !@request.get?
    end

    def html_response?
      @headers['Content-Type'] =~ /text\/html/
    end

    def build_turbolinks_response_to_render(html)
      escaped_html = ActionController::Base.helpers.j(html)
      <<-JS
        (function(){
          function renderWithTurbolinks(htmlContent){
            var currentSnapshot = Turbolinks.Snapshot.fromHTMLElement(document.documentElement);
            var newSpanshot = Turbolinks.Snapshot.fromHTMLString(htmlContent);
            var nullCallback = function(){};
            var nullDelegate = {viewInvalidated: nullCallback, viewWillRender: nullCallback, viewRendered: nullCallback};
          
            var renderer = new Turbolinks.SnapshotRenderer(currentSnapshot, newSpanshot, false);
            if(!renderer.shouldRender()){
              renderer = new Turbolinks.ErrorRenderer(htmlContent);
            }
            renderer.delegate = nullDelegate;
            renderer.render(nullCallback);
          }
          Turbolinks.clearCache();
          renderWithTurbolinks("#{escaped_html}");
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
