require 'test_helper'

class AccessControllerTest < ActionController::TestCase
  test "should get admin" do
    get :admin
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should get join_pool" do
    get :join_pool
    assert_response :success
  end

  test "should get menu" do
    get :menu
    assert_response :success
  end

end
