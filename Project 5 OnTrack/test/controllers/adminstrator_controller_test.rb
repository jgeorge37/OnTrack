require 'test_helper'

class AdminstratorControllerTest < ActionDispatch::IntegrationTest
  test "should get Panel" do
    get adminstrator_Panel_url
    assert_response :success
  end

  test "should get index" do
    get adminstrator_index_url
    assert_response :success
  end

end
