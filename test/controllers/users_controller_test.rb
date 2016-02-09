require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get wtf" do
    get :wtf
    assert_response :success
  end

end
