Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    get '/users/auth/do_omniauth', to: 'omniauth_callbacks#do_omniauth', as: :auth_callback_do
    get '/users/auth/service_sign_up', to: 'omniauth_callbacks#service_sign_up_users', as: :service_sign_up_users
    post '/users/auth/create_user_and_service', to: 'omniauth_callbacks#create_user_and_service', as: :create_user_and_service
  end

  authenticated(:user) do
    resources :users, :only => [:show] do
      resources :galleries do
        resources :pictures
      end
    end

    resources :grades
    root to: "secret#index", as: :authenticated_root
  end

  resources :grades, only: [:index, :show]
  root to: 'home#index'
end

