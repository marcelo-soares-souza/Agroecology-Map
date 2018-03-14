Rails.application.routes.draw do
  scope "(:locale)", :locale => /pt-BR|es|en/ do
    root :to => 'home#index'
    get "home/index"
  end

  resources :animais
  resources :plantas
  resources :experiencia_agroecologicas do
    resources :midias
  end

  resources :safs do
    resources :midias
  end

  resources :tema_experiencia_agroecologicas

  resources :locais do
    resources :experiencia_agroecologicas
    resources :safs 
  end

  resources :organizacoes
  resources :tipo_organizacoes

  devise_for :usuarios
  resources :usuarios

  get 'home/index'

  root to: "home#index"
end
