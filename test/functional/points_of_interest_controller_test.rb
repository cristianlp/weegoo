require 'test_helper'

class PointsOfInterestControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
