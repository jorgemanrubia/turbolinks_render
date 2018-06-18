require 'test_helper'
require 'selenium-webdriver'
require 'capybara'

capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'chromeOptions' => {
        'args' => ['--headless', '--disable-gpu']
    }
)

Capybara.register_driver :custom_headless_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end

Capybara.javascript_driver = :custom_headless_chrome

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :custom_headless_chrome, screen_size: [1400, 1400]
end

