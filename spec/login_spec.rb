
load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Login" do
    include TestHelper

    before(:all) do
      # browser_type, browser_options, site_url are defined in test_helper.rb
      @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
      driver.manage().window().resize_to(1280, 800)
      driver.get(site_url)
    end

    after(:all) do
      driver.quit unless debugging?
    end

    it "User can sign in OK" do
      driver.find_element(:id, "username").send_keys("agileway")
      driver.find_element(:id, "password").send_keys("testwise")
      driver.find_element(:name, "commit").click
      expect(driver.find_element(:tag_name, "body").text).to include("Signed in!")
      driver.find_element(:link_text,"Sign off").click
    end
    
    it "User failed to sign in due to invalid password" do
      driver.find_element(:id, "username").send_keys("agileway")
      driver.find_element(:id, "password").send_keys("badpass")
      driver.find_element(:name, "commit").click
      expect(driver.find_element(:tag_name, "body").text).to include("Invalid email or password")
    end
end