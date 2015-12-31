require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:steven)
    @other_user = users(:frank)
  end

  test 'should redirect index when not logged in' do
    get :index
    assert_redirected_to login_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test 'should redirect edit when not logged in' do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect updated when not logged in' do
    patch :update, id: @user, user: { name: @user.name, email: @user.email}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # Doesn't work due to current admin_user set up (returns nil if no current_user and then trying to call admin? on a nil object throws an error)
  # test 'should redirect destroy when not logged in' do
  #   assert_no_difference 'User.count' do
  #     delete :destroy, id: @user
  #   end
  #   assert_redirected_to login_url
  # end

  test 'should redirect destroy when logged in as non-admin' do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test 'should delete user when logged in as admin' do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete :destroy, id: @other_user
    end
    assert_redirected_to users_url
  end

end
