class AdjustmentsController < ApplicationController
  def new
    @adjustment = Adjustment.new
  end

  def create
    #byebug
    @adjustment = current_user.adjustments.build(adjustment_params)
    # adjusts the polarity of the value for expenses
    byebug
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
  end

  def edit
    @adjustment = Adjustment.find(params[:id])
  end

  def update
  end

  def destroy
    @adjustment.destroy
  end

  private

    def adjustment_params
      if params[:adjustment][:date] == 1
        params.require(:adjustment).permit(:value, :frequency, :frequency_num, :date)
      else
        params.require(:adjustment).permit(:value)
      end
    end
end
