Rails.application.routes.draw do
  resources :venues
  namespace :admin do
    resources :users
  end
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'landing#index'
  get 'landing/index'

  get 'home', to: 'home#index'
end
