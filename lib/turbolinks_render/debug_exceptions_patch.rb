module TurbolinksRender
  # Patch for ActionDispatch::DebugExceptions middleware
  module DebugExceptionsPatch
    def render_for_browser_request(request, wrapper)
      template = create_template(request, wrapper)
      file = "rescues/#{wrapper.rescue_template}"

      if request.xhr? && !request.get_header('X-Turbolinks-Render-Candidate')
        body = template.render(template: file, layout: false, formats: [:text])
        format = 'text/plain'
      else
        body = template.render(template: file, layout: 'rescues/layout')
        format = 'text/html'
      end
      render(wrapper.status_code, body, format)
    end
  end
end
