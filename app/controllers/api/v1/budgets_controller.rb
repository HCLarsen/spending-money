module Api::V1
  class BudgetsController < ApplicationController
    before_action :authenticate_api_v1_user!
    before_action :set_budget, only: [:show, :update, :destroy]

    def index
      budgets = current_api_v1_user.budgets
      render json: budgets, status: 200
    end

    def create
      budget = current_api_v1_user.budgets.build(budget_params)
      if budget.save
        render json: budget, status: 201
      else
      end
    end

    def show
      if @budget.user == current_api_v1_user
        render json: @budget, status: 200
      else
        render json: "Not Found", status: 404
      end
    end

    def update
      if @budget.user == current_api_v1_user
        if @budget.update(budget_params)
          render json: @budget, status: 200
        else
          render json: "Invalid Request", status: 400
        end
      else
        render json: "Not Found", status: 404
      end
    end

    def destroy
      @budget.destroy
      render status: 204
    end

    private

      def set_budget
        @budget = Budget.find(params[:id])
      end

      def budget_params
        params.require(:budget).permit(:name)
      end
  end
end
