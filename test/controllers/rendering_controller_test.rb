require 'test_helper'

class RenderingControllerTest < ActionDispatch::IntegrationTest
  [:put, :post].each do |http_verb|
    test "should render with turbolinks by default for ajax #{http_verb} requests" do
      put update_with_turbolinks_tasks_url, xhr: true
      assert_match /function/, @response.body
      assert_equal "text/javascript", @response.content_type
    end

    test "should let you to disable turbolinks with an option when invoking render  for ajax #{http_verb} requests " do
      put update_without_turbolinks_tasks_url, xhr: true
      assert_select 'p', text: 'Without turbolinks!'
      assert_equal "text/html", @response.content_type
    end
  end
end
