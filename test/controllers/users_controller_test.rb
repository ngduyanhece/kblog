require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:kevin)
    @other_user = users(:geek)
  end
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user 
    assert !flash.empty?
    assert_redirected_to root_url  
  end

  test "should redirect update when not logged in" do 
    get :update, id: @user, user: {name: @user.name, email: @user.email}
    assert !flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user 
    assert flash.empty?
    assert_redirected_to root_url 
  end

  test "should redirect update when logged in as wrong user" do 
    log_in_as(@other_user)
    get :update, id: @user, user: {name: @user.name, email: @user.email}
    assert flash.empty?
    assert_redirected_to root_url
  end
  test "should redirect index when not logged in" do 
    get :index 
    assert_redirected_to root_url
  end

  test "should redirect destroy when not log in" do 
    before_user_count = User.count 
    delete :destroy, id: @user 
    after_user_count = User.count 
    assert_equal before_user_count, after_user_count
    assert_redirected_to root_url 
  end

  test "should redirect destroy when logged in as a non-admin" do 
    log_in_as(@other_user)
    before_user_count = User.count 
    delete :destroy, id: @user
    after_user_count = User.count 
    assert_equal before_user_count, after_user_count
    assert_redirected_to root_url 
  end
end
