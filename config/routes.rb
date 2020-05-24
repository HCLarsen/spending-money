Rails.application.routes.draw do
  resources :adjustments
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
      resources :budgets, only: [:index, :create, :show, :update, :destroy]
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
end
