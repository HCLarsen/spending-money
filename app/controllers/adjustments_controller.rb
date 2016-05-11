class AdjustmentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @adjustment = Adjustment.new
  end

  def create
    @adjustment = current_user.adjustments.build(adjustment_params)
    # adjusts the polarity of the value for expenses
    if params[:adjustment][:income_or_expense] == "Expense"
      @adjustment.value *= -1
    end
    if @adjustment.save
      flash[:success] = "Adjustment Created"
      redirect_to adjustments_path
    end
  end

  def index
    @adjustments = current_user.adjustments
    @income = current_user.income
    @expenses = current_user.expenses
  end

  def edit
    @adjustment = Adjustment.find(params[:id])
  end

  def update
    @adjustment = Adjustment.find(params[:id])
    # adjusts the polarity of the value for expenses
    if params[:adjustment][:income_or_expense] == "Expense"
      params[:adjustment][:value] = "-" + params[:adjustment][:value]
    end
    if @adjustment.update(adjustment_params)
      flash[:success] = "Adjustment Created"
      redirect_to adjustments_path
    end
  end

  def destroy
    @adjustment = Adjustment.find(params[:id])
    @adjustment.destroy
    redirect_to adjustments_path
  end

  private

    def adjustment_params
      if params[:adjustment][:date] == "1"
        params.require(:adjustment).permit(:name, :value, :frequency, :frequency_num, :date)
      else
        params.require(:adjustment).permit(:name, :value)
      end
    end
end
