class CalculatorsController < ApplicationController
  before_action :authenticate_user!

  def create
    @result = params[:calculator][:balance].to_i + current_user.monthly_net
    render 'index'
  end

  def index
  end

  private

  def calculate
    total = 0
    self.income.each do |inc|
      if inc.date?

      else
        total += inc.value
      end
    end

    self.expenses.each do |exp|
    end
  end
end
