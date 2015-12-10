require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
  def setup 
    @micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do 
    assert_no_difference 'Micropost.count' do 
      post :create, micropost: {content: "sample content"}
    end
    assert_redirected_to root_url 
  end

  test "should redirect destroy when not logged in" do 
    assert_no_difference 'Micropost.count' do 
      delete :destroy, id: @micropost
    end
    assert_redirected_to root_url 
  end

  test "should redirect destroy for wrong micropost" do 
    log_in_as(users(:kevin))
    micropost = microposts(:zone)
    assert_no_difference 'Micropost.count' do 
      delete :destroy, id: micropost
    end
    assert_redirected_to root_url
  end
end
