Rails.application.routes.draw do
  resources :safs
  resources :locais
  resources :organizacoes
  resources :tipo_organizacoes
  devise_for :usuarios
  resources :usuarios

  get 'home/index'

  root to: "home#index"
end
