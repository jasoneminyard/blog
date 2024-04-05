require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  # simple test for code coverage, no need to actually test permitted params because they are either
  # permitted or they are not
  test 'user sign up' do
    get "/users/sign_up"
    assert_response :success

    post "/users", params: { "user"=>{"email"=>"test_guy_1@yahoo.com", "username"=>"Test Guy One",
        "password"=>"123456", "password_confirmation"=>"123456", "commit"=>"Sign up" } }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert User.last.username == "Test Guy One"    
  end
end
  