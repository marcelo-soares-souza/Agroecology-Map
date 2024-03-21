# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|pt-BR|es|fr/ do
    get "errors/not_found"
    get "errors/internal_server_error"

    root to: "home#index"
    get "home/index"

    get "map", to: "home#map"
    get "landing", to: "about#landing"
    get "about", to: "about#index"
    get "who_we_are", to: "about#who_we_are"
    get "manual", to: "about#manual"
    get "license", to: "about#license"
    get "thank_you_notes", to: "about#thank_you_notes"
    get "connect", to: "connect#index"
    get "dashboard", to: "dashboard#index"
    get "privacy_policy", to: "about#privacy_policy"

    get "coordinates", to: "locations#coordinates"
    get "countries", to: "locations#countries"
    put "/practices/:id/like", to: "practices#like", as: "like"

    resources :practices
    resources :acknowledges
    resources :evaluates
    resources :characterises
    resources :what_you_dos
    resources :comments

    resources :practices do
      resources :acknowledges
      resources :evaluates
      resources :characterises
      resources :what_you_dos
      resources :medias
      resources :documents
      resources :comments
      get "/gallery" => "medias#gallery"
    end

    resources :locations do
      get "/gallery" => "medias#gallery"
      resources :practices
      resources :medias
      resources :documents
    end

    devise_for :accounts, controllers: {
      registrations: "accounts/registrations",
      sessions: "accounts/sessions",
      confirmations: "accounts/confirmations"
    }

    resources :accounts do
      resources :locations
      resources :practices
    end

    post "login", to: "authentication#login"
    post "signup", to: "authentication#signup"
    post "validate_jwt_token", to: "authentication#validate_jwt_token"

    match "/404", to: "errors#not_found", via: :all
    match "/500", to: "errors#internal_server_error", via: :all
    match "/422", to: "errors#unprocessable_entity", via: :all
  end
end
