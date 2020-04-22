require 'test_helper'

class EvaluationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get evaluations_index_url
    assert_response :success
  end

end
