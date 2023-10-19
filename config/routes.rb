# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /pt-BR|es|en|fr|gl/ do
    root to: "home#index"
    get "home/index"
  end

  get "/map", to: "home#index"
  get "dashboard", to: "dashboard#index"

  resources :friends
  resources :manual
  resources :comentarios

  scope(animais: {}) do
    resources :animais, path: "animals"
  end

  resources :animais

  scope(plantas: {}) do
    resources :plantas, path: "plants"
  end

  resources :plantas

  scope(experiencia_agroecologicas: {}) do
    resources :experiencia_agroecologicas, path: "agroecological-experiences"
  end

  resources :experiencia_agroecologicas do
    get "/gallery" => "midias#gallery"
    resources :midias
    resources :comentarios
  end

  scope(safs: {}) do
    resources :safs, path: "agroforestry"
  end

  resources :safs do
    get "/gallery" => "midias#gallery"
    resources :midias
  end

  resources :tema_experiencia_agroecologicas

  scope(locais: {}) do
    resources :locais, path: "locations"
  end

  resources :locais do
    get "/gallery" => "midias#gallery"
    resources :experiencia_agroecologicas
    resources :safs
    resources :blogs, path: "blog"
  end

  resources :organizacoes

  resources :tipo_organizacoes

  scope(usuarios: {}) do
    resources :usuarios, path: "contributors"
  end

  #  devise_for :usuarios
  devise_for :usuarios, controllers: {
    registrations: "usuarios/registrations"
  }

  resources :usuarios do
    resources :locais
    resources :experiencia_agroecologicas
  end

  resources :novidades, only: [:index]

  put "/agroecological-experiences/:id/like", to: "experiencia_agroecologicas#like", as: "like"
end
