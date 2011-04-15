require 'test_helper'

class DatabasesControllerTest < ActionController::TestCase
  setup do
    @database = databases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:databases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create database" do
    assert_difference('Database.count') do
      post :create, :database => @database.attributes
    end

    assert_redirected_to database_path(assigns(:database))
  end

  test "should show database" do
    get :show, :id => @database.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @database.to_param
    assert_response :success
  end

  test "should update database" do
    put :update, :id => @database.to_param, :database => @database.attributes
    assert_redirected_to database_path(assigns(:database))
  end

  test "should destroy database" do
    assert_difference('Database.count', -1) do
      delete :destroy, :id => @database.to_param
    end

    assert_redirected_to databases_path
  end
end
