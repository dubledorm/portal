Rails.application.routes.draw do

  devise_for :users

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end


  match '/auth/facebook/callback' => 'services#create', :via => :get
  resources :services, :only => [:index, :create]

  root to: 'home#index'
end

