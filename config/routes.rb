Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    get '/users/auth/do_omniauth', to: 'omniauth_callbacks#do_omniauth', as: :auth_callback_do
  end

  authenticated do
    resources :users, :only => [:show, :edit, :update]
    root to: "secret#index", as: :authenticated_root
  end

  root to: 'home#index'
end

