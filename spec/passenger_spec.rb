
load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Passenger" do
    include TestHelper

    before(:all) do
      # browser_type, browser_options, site_url are defined in test_helper.rb
      @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
      driver.manage().window().resize_to(1280, 800)
      driver.get(site_url)
      login_page = LoginPage.new(driver)
      login_page.login("agileway","testwise")
    end

    after(:all) do
      driver.quit unless debugging?
    end

    it "[4] Can enter passenger details (using page objects)" do
      flight_page = FlightPage.new(driver)
      flight_page.select_trip_type("return")
      flight_page.select_from("San Francisco")
      flight_page.select_arrive_at("Sydney")
      flight_page.select_depart_day("29")
      flight_page.select_depart_month("January 2021")
      flight_page.select_return_day("11")
      flight_page.select_return_month("August 2021")
      flight_page.click_continue()
      
      passenger_page = PassengerPage.new(driver)
      passenger_page.click_next
      expect(page_text).to include("Must provide last name")
      passenger_page.enter_first_name("Huy Vy")
      passenger_page.enter_last_name("Le")
      passenger_page.click_next()
      expect(driver.find_element(:name, "holder_name").attribute("value")).to eq("Huy Vy Le")
    end

end


