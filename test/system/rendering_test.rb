require 'application_system_test_case'

class TurbolinksRailsRender::RenderingTest < ApplicationSystemTestCase
  test "Rendering should be handled by turbolinks when submitting an ajax form and turbolink rendering is enabled" do
    with_default_option_for_rendering_with_turbolinks(true) do
      visit new_task_path
      fill_in 'Title', with: ''
      click_on 'Create Task'
      assert_content "Title can't be blank"
    end
  end

  test "Rendering should not be handled by turbolinks work when submitting an ajax form and turbolink rendering is disabled" do
    with_default_option_for_rendering_with_turbolinks(false) do
      visit new_task_path
      fill_in 'Title', with: ''
      click_on 'Create Task'
      assert_no_content "Title can't be blank"
    end
  end

  def with_default_option_for_rendering_with_turbolinks(value)
    original_value = Rails.application.config.turbolinks_render.render_with_turbolinks_by_default
    Rails.application.config.turbolinks_render.render_with_turbolinks_by_default = value
    yield
  ensure
    Rails.application.config.turbolinks_render.render_with_turbolinks_by_default = original_value
  end
end
