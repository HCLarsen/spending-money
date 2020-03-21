require 'test_helper'

class BudgetTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "should save with proper info" do
    budget = @user.budgets.new(name: "Personal")
    assert budget.save
  end

  test "shouldn't save without name" do
    budget = @user.budgets.new
    refute budget.save
  end

  test "shouldn't save without user id" do
    budget = Budget.new(name: "Personal")
    refute budget.save
  end
end
