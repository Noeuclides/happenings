Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'landing#index'
  get 'landing/index'

  get 'home', to: 'home#index'
end
