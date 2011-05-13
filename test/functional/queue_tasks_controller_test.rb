require 'test_helper'

class QueueTasksControllerTest < ActionController::TestCase
  setup do
    @queue_task = queue_tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:queue_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create queue_task" do
    assert_difference('QueueTask.count') do
      post :create, :queue_task => @queue_task.attributes
    end

    assert_redirected_to queue_task_path(assigns(:queue_task))
  end

  test "should show queue_task" do
    get :show, :id => @queue_task.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @queue_task.to_param
    assert_response :success
  end

  test "should update queue_task" do
    put :update, :id => @queue_task.to_param, :queue_task => @queue_task.attributes
    assert_redirected_to queue_task_path(assigns(:queue_task))
  end

  test "should destroy queue_task" do
    assert_difference('QueueTask.count', -1) do
      delete :destroy, :id => @queue_task.to_param
    end

    assert_redirected_to queue_tasks_path
  end
end
