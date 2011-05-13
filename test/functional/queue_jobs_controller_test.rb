require 'test_helper'

class QueueJobsControllerTest < ActionController::TestCase
  setup do
    @queue_job = queue_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:queue_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create queue_job" do
    assert_difference('QueueJob.count') do
      post :create, :queue_job => @queue_job.attributes
    end

    assert_redirected_to queue_job_path(assigns(:queue_job))
  end

  test "should show queue_job" do
    get :show, :id => @queue_job.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @queue_job.to_param
    assert_response :success
  end

  test "should update queue_job" do
    put :update, :id => @queue_job.to_param, :queue_job => @queue_job.attributes
    assert_redirected_to queue_job_path(assigns(:queue_job))
  end

  test "should destroy queue_job" do
    assert_difference('QueueJob.count', -1) do
      delete :destroy, :id => @queue_job.to_param
    end

    assert_redirected_to queue_jobs_path
  end
end
