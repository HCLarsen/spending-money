require 'test_helper'

class AdjustmentTest < ActiveSupport::TestCase
  def setup
    @budget = budgets(:one)
  end

  test "should save with necessary values" do
    adjustment = @budget.adjustments.new(name: "books", amount: 10)
    assert adjustment.save
  end

  test "shouldn't save without name" do
    adjustment = @budget.adjustments.new(amount: 10)
    refute adjustment.save
  end

  test "shouldn't save without amount" do
    adjustment = @budget.adjustments.new(name: "rent")
    refute adjustment.save
  end
end
