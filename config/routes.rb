Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users
  resources :pages, only: [:index]
  resources :follows, only: [:create, :update, :destroy]
  resources :mark_restaurants, only: [:index, :create, :update, :destroy]
  resources :went_restaurants, only: [:create, :destroy]

  get 'restaurants/index'
  get 'restaurants/show'

  root to: 'pages#index'
end
