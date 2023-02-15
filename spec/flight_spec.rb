load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Select Flight" do
    include TestHelper

    before(:all) do
      # browser_type, browser_options, site_url are defined in test_helper.rb
      @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
      driver.manage().window().resize_to(1280, 800)
      driver.get(site_url)
      
      login_page = LoginPage.new(driver)
      login_page.login("agileway","testwise")
    end
    
    before(:each) do
      # before each test, make sure on flight page_text
      visit("/")
    end
    
    after(:all) do
      driver.quit unless debugging?
    end

    it "One way trip" do
      flight_page = FlightPage.new(driver)
      flight_page.select_trip_type("oneway")
      flight_page.select_from("Sydney")
      flight_page.select_arrive_at("New York")
      flight_page.select_depart_day("02")
      flight_page.select_depart_month("May 2016")
      flight_page.click_continue()
      expect(page_text).to include("2016-05-02 Sydney to New York")
      #driver.find_element(:link_text,"Sign off").click
    end
    
    it "Return trip" do
      flight_page = FlightPage.new(driver)
      flight_page.select_trip_type("return")
      flight_page.select_from("Sydney")
      flight_page.select_arrive_at("New York")
      flight_page.select_depart_day("02")
      flight_page.select_depart_month("May 2016")
      flight_page.select_return_day("07")
      flight_page.select_return_month("September 2016")
      flight_page.click_continue()
      expect(page_text).to include("2016-05-02 Sydney to New York")
      expect(page_text).to include("2016-09-07 New York to Sydney")
    end

end


