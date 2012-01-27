require 'test_helper'

class SiteInstancesControllerTest < ActionController::TestCase
  test "should get enable" do
    get :enable
    assert_response :success
  end

  test "should get disable" do
    get :disable
    assert_response :success
  end

end
