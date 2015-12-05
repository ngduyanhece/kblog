require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup 
    @user = users(:kevin)
  end
  test "login with invalid information" do 
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, session: {email: " ", password: " "}
  	assert_template 'sessions/new'
  	assert !flash.empty?
  	get root_path
  	assert flash.empty?, "flash should be empty when go to the root_path"
  end

  test "login with valid information followed by  logout" do 
    get login_path
    assert_template 'sessions/new'
    post login_path, session: {email: "kevinnguyen@gmail.com", password: "password"}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert !is_logged_in?
    assert_redirected_to root_path
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "log in with remembering" do 
    log_in_as(@user,remember_me: '1')
    assert !cookies['remember_token'].nil?
  end

  test "log in without remembering" do 
    log_in_as(@user,remember_me: '0')
    assert  cookies['remember_token'].nil?
  end
end
