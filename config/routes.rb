Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
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

  namespace :api do
    namespace :v1 do
      resources :users
      devise_for :users, controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations',
        confirmations: 'api/v1/confirmations'
      }, skip: [:sessions, :registrations, :confirmations], defaults: { format: :json }
      as :user do
        post 'login', to: 'sessions#create', as: :user_session
        delete 'logout', to: 'sessions#destroy', as: :destroy_user_session
        post 'signup', to: 'registrations#create', as: :user_registration
      end
    end
  end
end
