Rails.application.routes.draw do
  #get 'calculators/show'
  #get 'calculators/create'

  resources :calculators, only: [:create, :index]

  root                'pages#home'
  get  'profile' =>   'users#show'

  resources :adjustments

  devise_for :users, :controllers => { registrations: 'registrations' }
end
