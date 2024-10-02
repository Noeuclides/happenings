Rails.application.routes.draw do
  root to: 'landing#index'
  get 'landing/index'

  get 'home', to: 'home#index'

  resources :events do
    member do
      post 'register'
      delete 'unregister'
    end
  end

  resources :venues
  namespace :admin do
    resources :users
  end
  # devise_for :users
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
