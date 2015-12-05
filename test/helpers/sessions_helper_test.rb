require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup 
    @user = users(:kevin)
    remember (@user)
  end

  test "current user rerturn right when seesion is nil" do 
    assert_equal @user, current_user
    assert is_logged_in?
  end
  test "current user returns nill when remember digest is wrong" do 
    @user.update_attribute(:remember_digest,User.digest(User.new_token))
    assert current_user.nil?
  end
end