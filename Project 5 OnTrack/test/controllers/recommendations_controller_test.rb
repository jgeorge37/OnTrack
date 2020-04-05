require 'test_helper'

class RecommendationsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get recommendations_list_url
    assert_response :success
  end

  test "should get new" do
    get recommendations_new_url
    assert_response :success
  end

  test "should get show" do
    get recommendations_show_url
    assert_response :success
  end

  test "should get edit" do
    get recommendations_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get recommendations_destroy_url
    assert_response :success
  end

end
