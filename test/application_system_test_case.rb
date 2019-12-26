require 'test_helper'
require 'webdrivers'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium_chrome_headless, screen_size: [1400, 1400]
end
