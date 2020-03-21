require 'test_helper'

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login_params = {
      email: 'tstark@example.org',
      password: 'FakePassword123!',
    }
    post api_v1_user_session_path, headers: login_params
    headers = response.headers
    @authenticate_params = {
      'access-token': headers['access-token'],
      'client': headers['client'],
      'expiry': headers['expiry'],
      'uid': headers['uid'],
    }
  end

  test "should return list of budgets for logged in user" do
    get api_v1_budgets_path, headers: @authenticate_params
    assert_response :success

    budgets = JSON.parse(response.body)
    assert_equal 2, budgets.length
    assert_equal "Personal", budgets.last["name"]
  end

  test "shouldn't return budget list without authentication" do
    get api_v1_budgets_path
    assert_response(401)
  end

  test "should return a budget for logged in user" do
    get api_v1_budget_path(980190962), headers: @authenticate_params
    assert_response :success
    budget = JSON.parse(response.body)
    assert_equal "Personal", budget["name"]
  end

  test "shouldn't return a budget for other user" do
    get api_v1_budget_path(113629430), headers: @authenticate_params
    assert_response(404)
  end

  test "should create budget" do
    get api_v1_budgets_path, headers: @authenticate_params
    budgets = JSON.parse(response.body)
    number = budgets.length

    new_budget = {
      budget: { name: "Joint" }
    }
    post api_v1_budgets_path, headers: @authenticate_params, params: new_budget
    assert_response(201)
    budget = JSON.parse(response.body)
    assert_equal "Joint", budget["name"]

    get api_v1_budgets_path, headers: @authenticate_params
    budgets = JSON.parse(response.body)
    assert_equal number + 1, budgets.length
  end

  test "should update budget" do
    budget = {
      budget: { name: "Joint" }
    }
    put api_v1_budget_path(980190962), headers: @authenticate_params, params: budget
    assert_response :success
    budget = JSON.parse(response.body)
    assert_equal "Joint", budget["name"]
  end

  test "should delete budget" do
    get api_v1_budgets_path, headers: @authenticate_params
    budgets = JSON.parse(response.body)
    number = budgets.length

    delete api_v1_budget_path(980190962), headers: @authenticate_params
    assert_response(204)

    get api_v1_budgets_path, headers: @authenticate_params
    budgets = JSON.parse(response.body)
    assert_equal number - 1, budgets.length
  end
end
