require 'test_helper'

class EvaluationControllerTest < ActionDispatch::IntegrationTest
  test "should get evaluation" do
    get evaluation_evaluation_url
    assert_response :success
  end

end
