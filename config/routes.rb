Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end

  # namespace 'auth' do
  #   resources :services, :only => [:index, :create, :destroy]
  # end
  # get '/auth/:service/callback', to: 'auth/services#create', as: :auth_callback

  root to: 'home#index'
end

