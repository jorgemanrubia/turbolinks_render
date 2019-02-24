require 'application_system_test_case'

class TurbolinksRenderingTest < ApplicationSystemTestCase
  def setup
    Rails.application.config.action_dispatch.show_exceptions = true
  end

  def teardown
    Rails.application.config.action_dispatch.show_exceptions = false
  end

  test 'Rendering should be handled by turbolinks when submitting an ajax form with turbolink rendering enabled' do
    with_default_option_for_rendering_with_turbolinks(true) do
      visit new_task_path
      fill_in 'Title', with: ''
      click_on 'Create Task'
      assert_content "Title can't be blank"
    end
  end

  test 'Rendering should not be handled by turbolinks when submitting an ajax form with turbolink rendering disabled' do
    with_default_option_for_rendering_with_turbolinks(false) do
      visit new_task_path
      fill_in 'Title', with: ''
      click_on 'Create Task'
      assert_no_content "Title can't be blank"
    end
  end

  test '500 errors are properly rendered' do
    with_default_option_for_rendering_with_turbolinks(true) do
      visit new_task_path
      fill_in 'Title', with: 'force error 5002'
      click_on 'Create Task'
      assert_content "Title can't be blank"
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
