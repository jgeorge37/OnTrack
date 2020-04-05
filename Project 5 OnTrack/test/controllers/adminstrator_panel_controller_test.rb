require 'test_helper'

class AdminstratorPanelControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get adminstrator_panel_index_url
    assert_response :success
  end

end
