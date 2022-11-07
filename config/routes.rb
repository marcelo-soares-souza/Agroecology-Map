# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /pt-BR|es|en|fr/ do
    root to: "home#index"
    get "home/index"
  end

  resources :friends
  resources :comentarios
  resources :animais
  resources :plantas

  resources :experiencia_agroecologicas do
    resources :midias
    resources :comentarios
  end

  resources :safs do
    resources :midias
  end

  resources :tema_experiencia_agroecologicas

  resources :locais do
    resources :experiencia_agroecologicas
    resources :safs
    resources :blogs, path: "blog"
  end

  resources :organizacoes

  resources :tipo_organizacoes

  #  devise_for :usuarios
  devise_for :usuarios, controllers: {
    registrations: "usuarios/registrations"
  }

  resources :usuarios do
    resources :locais
    resources :experiencia_agroecologicas
  end

  resources :novidades, only: [:index]
end
