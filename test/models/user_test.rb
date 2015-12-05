require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example", email: "user@example.com",
                     password: "password", password_confirmation: "password")
  end

  test "should be valid" do 
    assert @user.valid?, "user should be valid"
  end

  test "name should be presented" do 
    @user.name = ""
    assert  !@user.valid?, "name should be presented"
  end 

  test "email should be presented" do 
    @user.email = ""
    assert !@user.valid?, "email should be presented"
  end

  test "name should not be long" do 
    @user.name = "a"*100
    assert !@user.valid?, "name should not be long"
  end

  test "email should not be too long" do 
    @user.email = "b"*255 + "@example.com"
    assert !@user.valid?, "name should not be too long"
  end

  test "email addresses should not be unique" do 
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save 
    assert !duplicate_user.valid?, "email should be unique"
  end

  test "email addresses should be saved as lower-case" do 
    mixed_case_email = "Foo@ExAMple.Com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be nonblank" do 
    @user.password = " "*10
    @user.password_confirmation = " "*10
    assert !@user.valid?, "password should be nonblank"
  end

  test "password should have a minimum length" do 
    @user.password = "a"*5
    @user.password_confirmation = "a"*5
    assert !@user.valid?, "password should be at least 6 characters"
  end

  test "authenticated? should return false for a user with nil digest" do 
    assert !@user.authenticated?('')
  end
end
