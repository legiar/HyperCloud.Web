require 'test_helper'

class SlicesControllerTest < ActionController::TestCase
  setup do
    @slice = slices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slice" do
    assert_difference('Slice.count') do
      post :create, :slice => @slice.attributes
    end

    assert_redirected_to slice_path(assigns(:slice))
  end

  test "should show slice" do
    get :show, :id => @slice.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @slice.to_param
    assert_response :success
  end

  test "should update slice" do
    put :update, :id => @slice.to_param, :slice => @slice.attributes
    assert_redirected_to slice_path(assigns(:slice))
  end

  test "should destroy slice" do
    assert_difference('Slice.count', -1) do
      delete :destroy, :id => @slice.to_param
    end

    assert_redirected_to slices_path
  end
end
