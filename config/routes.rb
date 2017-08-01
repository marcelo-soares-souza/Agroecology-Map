Rails.application.routes.draw do
  devise_for :usuarios
  resources :usuarios

  get 'home/index'

  root to: "home#index"
end
