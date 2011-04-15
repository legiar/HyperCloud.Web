require 'test_helper'

class NetworkAddressesControllerTest < ActionController::TestCase
  setup do
    @network_address = network_addresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:network_addresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create network_address" do
    assert_difference('NetworkAddress.count') do
      post :create, :network_address => @network_address.attributes
    end

    assert_redirected_to network_address_path(assigns(:network_address))
  end

  test "should show network_address" do
    get :show, :id => @network_address.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @network_address.to_param
    assert_response :success
  end

  test "should update network_address" do
    put :update, :id => @network_address.to_param, :network_address => @network_address.attributes
    assert_redirected_to network_address_path(assigns(:network_address))
  end

  test "should destroy network_address" do
    assert_difference('NetworkAddress.count', -1) do
      delete :destroy, :id => @network_address.to_param
    end

    assert_redirected_to network_addresses_path
  end
end
