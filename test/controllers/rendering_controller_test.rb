require 'test_helper'

class RenderingControllerTest < ActionDispatch::IntegrationTest
  [:put, :post].each do |http_verb|
    test "Render with turbolinks by default for ajax #{http_verb} requests" do
      send http_verb, update_with_turbolinks_tasks_url, xhr: true
      assert_match /function/, @response.body
      assert_equal "text/javascript", @response.content_type
    end

    test "Turbolinks rendering can be disabled with `turbolinks: false` (for #{http_verb})" do
      send http_verb, update_without_turbolinks_tasks_url, xhr: true
      assert_select 'p', text: 'Without turbolinks!'
      assert_equal "text/html", @response.content_type
    end
  end
end
