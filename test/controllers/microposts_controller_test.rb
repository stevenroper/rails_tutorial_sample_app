require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase

  def setup
    @micropost = microposts(:architecture)
  end

  test 'should redirect create if not logged in' do
    assert_no_difference 'Micropost.count' do
      post :create, micropost: { content: 'Things' }
    end
    assert_redirected_to login_url
  end

  test 'shoud redirect delete if not logged in' do
    assert_no_difference 'Micropost.count' do
      post :destroy, id: @micropost
    end
    assert_redirected_to login_url
  end
end
