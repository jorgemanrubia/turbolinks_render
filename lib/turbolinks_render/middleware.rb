module TurbolinksRender
  class Middleware
    Request = Struct.new(:request) do
      def candidate_for_turbolinks?
        request.xhr? && !request.get?
      end

      def turbolinks_render_option
        @turbolinks_render_option ||= request.get_header('X-Turbolinks-Render-Option')
      end

      def fullpath
        request.fullpath
      end
    end

    Response = Struct.new(:status, :headers, :response) do
      def candidate_for_turbolinks?
        html_response? && !empty?
      end

      def turbolinks_body
        @turbolinks_body ||= js_code_to_render_html(body)
      end

      private

      def empty?
        body.blank?
      end

      def html_response?
        headers['Content-Type'] =~ %r{text/html}
      end

      def body
        @body ||= begin
          body = ''
          # Response does not have to be an Enumerable. It just has to respond to #each according to Rack spec
          response.each { |part| body << part }
          body
        end
      end

      def js_code_to_render_html(html)
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
          Turbolinks.dispatch('turbolinks:before-cache');
          renderWithTurbolinks("#{escaped_html}");
          window.scroll(0, 0);
          Turbolinks.dispatch('turbolinks:load');
        })();
        JS
      end
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      rack_request = Rack::Request.new(env)
      request = Request.new(rack_request)
      rack_request.set_header('X-Turbolinks-Render-Candidate', request.candidate_for_turbolinks?)

      rack_status, rack_headers, rack_response = @app.call(env)
      response = Response.new(rack_status, rack_headers, rack_response)

      return [rack_status, rack_headers, rack_response] unless render_with_turbolinks?(request, response)

      rack_headers['Content-Type'] = 'text/javascript'
      rack_headers['Content-Length'] = response.turbolinks_body.bytesize.to_s

      [rack_status, rack_headers, [response.turbolinks_body]]
    end

    private

    def render_with_turbolinks?(request, response)
      request.candidate_for_turbolinks? && response.candidate_for_turbolinks? &&
        ignored_paths.none? { |path| request.fullpath.starts_with?(path) } &&
        (request.turbolinks_render_option || (render_with_turbolinks_by_default? && request.turbolinks_render_option != false))
    end

    def render_with_turbolinks_by_default?
      Rails.application.config.turbolinks_render.render_with_turbolinks_by_default
    end

    def ignored_paths
      Rails.application.config.turbolinks_render.ignored_paths
    end
  end
end
