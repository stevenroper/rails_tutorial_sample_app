require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:steven)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {
                                  name: '',
                                  email: 'invalid@email',
                                  password: 'foo',
                                  password_confirmation: 'bar'
                                  }
    assert_template 'users/edit'
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Ben Wyatt'
    email = 'ben@pawnee.gov'
    patch user_path(@user), user: {
                                  name: name,
                                  email: email,
                                  password: '',
                                  password_confirmation: ''
                                  }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
