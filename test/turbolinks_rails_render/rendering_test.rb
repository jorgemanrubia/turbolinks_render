require 'application_system_test_case'

class TurbolinksRailsRender::RenderingTest < ApplicationSystemTestCase
  test "Rendering should be handled by turbolinks when submitting an ajax form and turbolink rendering is enabled" do
    visit new_task_path
    fill_in 'Title', with: ''
    click_on 'Create Task'
    assert_content "Title can't be blank"
  end

  test "Rendering should not be handled by turbolinks work when submitting an ajax form and turbolink rendering is disabled" do
    Rails.application.config.turbolinks_render.render_with_turbolinks_by_default = false

    visit new_task_path
    fill_in 'Title', with: ''
    click_on 'Create Task'
    assert_no_content "Title can't be blank"
  end
end
