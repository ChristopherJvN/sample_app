require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name:  '',
                               email_address: 'user@invalid',
                               password:              'foo',
                               password_confirmation: 'bar' }
    end
    assert_template 'users/new'
  end

    test 'validate signup information' do
      get signup_path
        post_via_redirect users_path, user: { name:  'foo',
                                 email_address: 'user@invalid.com',
                                 password:              'foo111',
                                 password_confirmation: 'foo111' }
      assert_template 'users/show'
    end
end
