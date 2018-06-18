require 'application_system_test_case'

class Turbolinks::RebderingTest < ApplicationSystemTestCase
  test "Rendering should work when submitting a form with turbolinks" do
    visit new_task_path
    fill_in 'Title', with: ''
    click_on 'Create Task'
    assert_content "Title can't be blank"
  end
end
