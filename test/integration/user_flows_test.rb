require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  def setup
    @sign_up_url = '/api/v1/auth/'
    @signup_params = {
        email: 'john.doe@example.org',
        password: 'FakePassword123!',
        password_confirmation: 'FakePassword123!'
    }

    @sign_in_url = '/api/v1/auth/sign_in'
    @sign_out_url = '/api/v1/auth/sign_out'
    @login_params = {
      email: 'john.doe@example.org',
      password: 'FakePassword123!',
    }
  end

  test "should register and allow login" do
    post @sign_up_url, params: @signup_params
    assert_response :success

    post @sign_in_url, params: @login_params
    assert_response :success
    content = JSON.parse(response.body)
    id = content["data"]["id"]
    token = response.headers['access-token']
    assert response.headers['access-token']
  end

  test "shouldn't render user profile without login" do
    get '/api/v1/users/1'
    assert_response(401)
  end

  test "should render user profile after logging in" do
    post @sign_up_url, params: @signup_params
    post @sign_in_url, params: @login_params
    headers = response.headers
    authenticate_params = {
      'access-token': headers['access-token'],
      'client': headers['client'],
      'expiry': headers['expiry'],
      'uid': headers['uid'],
    }
    get '/api/v1/users/1', params: authenticate_params
    assert_response :success
    content = JSON.parse(response.body)
    assert_equal "john.doe@example.org", content["email"]
  end
end
