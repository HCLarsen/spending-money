module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_api_v1_user!

    def show
      render json: current_api_v1_user, status: 200
    end
  end
end
