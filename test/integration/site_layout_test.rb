require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "site layout" do 
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get signup_path
    assert_template 'users/new'
    assert_select "title", full_title("Sign up")   
  end
  test "full title helper" do 
  	assert_equal full_title, "Keblog"
  	assert_equal full_title("Help"), "Help | Keblog"
  end
end
