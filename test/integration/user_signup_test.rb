require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do 
    get signup_path 
    before_count = User.count
    post users_path, user: {name: "", email: "user@gmail.com", password: "foo123", password_confirmation: "foo123"}
    after_count = User.count
    assert_equal before_count, after_count
    assert_template 'users/new'
  end

  test "valid signup information" do 
    get signup_path 
    before_count = User.count
    post users_path, user: {name: "user", email: "user@gmail.com", password: "foo123", password_confirmation: "foo123"}
    follow_redirect!
    after_count = User.count
    assert_not_equal before_count, after_count
    assert_template 'users/show'
  end

end
