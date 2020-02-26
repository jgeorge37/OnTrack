require 'test_helper'

class DataScraperControllerTest < ActionDispatch::IntegrationTest
  test "should get scrape" do
    get data_scraper_scrape_url
    assert_response :success
  end

  test "should get list" do
    get data_scraper_list_url
    assert_response :success
  end

end
