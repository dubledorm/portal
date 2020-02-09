Rails.application.routes.draw do

  devise_for :users

  authenticated do
    root to: "secret#index", as: :authenticated_root
  end

  root to: 'home#index'
end
