Rails.application.routes.draw do
  resources :animais
  resources :plantas
  resources :experiencia_agroecologicas do
    resources :midias
  end

  resources :safs do
    resources :midias
  end

  resources :tema_experiencia_agroecologicas
  resources :locais
  resources :organizacoes
  resources :tipo_organizacoes

  devise_for :usuarios
  resources :usuarios

  get 'home/index'

  root to: "home#index"
end
