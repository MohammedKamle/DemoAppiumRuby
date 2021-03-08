require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'appium_lib'
require 'browserstack/local'

class ParallelAndroidAppTest < Test::Unit::TestCase

  def setup
  	caps = {}
		caps['device'] = ENV['device'] #'Google Pixel'
		caps['os_version'] = ENV['os_version']
		caps['realMobile'] = true
		caps['app'] = 'DemoApp'

		caps['project'] = ENV['project'] #"BrowserStack"
		caps['build'] = ENV['build'] #"Demo"
		caps['name'] = ENV['name'] #"Wikipedia Search Function"

		caps['browserstack.debug'] = true
    
	appium_driver = Appium::Driver.new({
		'caps' => caps,
		'appium_lib' => {
			:server_url => "http://#{ENV["BROWSERSTACK_USER"]}:#{ENV["BROWSERSTACK_ACCESSKEY"]}@hub-cloud.browserstack.com/wd/hub"
		}}, true)
	@driver = appium_driver.start_driver
  end

  def test_post
	  wait = Selenium::WebDriver::Wait.new(:timeout => 30)
		wait.until { @driver.find_element(:accessibility_id, "Search Wikipedia").displayed? }
		element = @driver.find_element(:accessibility_id, "Search Wikipedia")
		element.click

		wait.until { @driver.find_element(:id, "org.wikipedia.alpha:id/search_src_text").displayed? }
		search_box = @driver.find_element(:id, "org.wikipedia.alpha:id/search_src_text")
		search_box.send_keys("BrowserStack")

		wait.until { @driver.find_element(:class, "android.widget.TextView").displayed? }
		results = @driver.find_elements(:class, "android.widget.TextView")

		results_count = results.count

		assert_equal(results_count, results_count)
  end

  def teardown
    @driver.quit
  end
  
end
