Rails.application.routes.draw do

  devise_for :users

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end


  get '/auth/:service/callback', to: 'services#create', as: :auth_callback
  resources :services, :only => [:index, :create, :destroy]

  root to: 'home#index'
end

