Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'users/registrations' }
  devise_scope :user do
    get '/users/auth/do_omniauth', to: 'omniauth_callbacks#do_omniauth', as: :auth_callback_do
    get '/users/auth/service_sign_up', to: 'omniauth_callbacks#service_sign_up_users', as: :service_sign_up_users
    post '/users/auth/create_user_and_service', to: 'omniauth_callbacks#create_user_and_service', as: :create_user_and_service
  end

  authenticated(:user) do

    put 'users/:id/update_category', to: 'user_cabinet/users#update_category', as: :user_update_category

    resources :users, only: [:show, :edit, :update] do
      get :profile, on: :member, to: 'user_profile/users#show', as: :user_profile
      put :profile, on: :member, to: 'user_profile/users#update'

      scope module: 'user_profile' do
        resources :services, only: [:destroy]
      end

      get :cabinet, on: :member, to: 'user_cabinet/users#show', as: :user_cabinet
      scope module: 'user_cabinet' do
        resources :galleries
        resources :pictures
      end

      resources :articles
    end

    resources :grades
    resources :articles, only: [:index, :show]
    root to: "secret#index", as: :authenticated_root
  end

  resources :grades, only: [:index, :show]
  resources :articles, only: [:index, :show]
#  resources :galleries, only: [:index, :show]
  root to: 'home#index'
end

