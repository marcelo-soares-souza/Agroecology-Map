# frozen_string_literal: true

Rails.application.routes.draw do
  resources :jobs, only: [:create]

  authenticate :account, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  scope "(:locale)", locale: /en|pt-BR|es|fr/ do
    get "health" => "rails/health#show", as: :rails_health_check
    get "errors/not_found"
    get "errors/internal_server_error"

    root to: "home#index"
    get "home/index"

    get "reduced_map", to: "home#reduced_map"
    get "map", to: "home#index"
    get "agroecology", to: "about#agroecology"
    get "landing", to: "about#landing"
    get "about", to: "about#index"
    get "who_we_are", to: "about#who_we_are"
    get "how_to_register", to: "about#how_to_register"
    get "partners", to: "about#partners"
    get "friends", to: "about#partners"
    get "manual", to: "about#manual"
    get "license", to: "about#license"
    get "source_code_license", to: "about#source_code_license"
    get "thank_you_notes", to: "about#thank_you_notes"
    get "contact", to: "about#contact"
    get "projects_and_groups", to: "about#projectsandgroups"
    get "dashboard", to: "dashboard#index"
    get "privacy_policy", to: "about#privacy_policy"

    get "coordinates", to: "locations#coordinates"
    get "countries", to: "locations#countries"
    get "/gallery", to: "medias#gallery"

    put "/practices/:id/like", to: "practices#like", as: "like_practice"
    put "/locations/:id/like", to: "locations#like", as: "like_location"
    post "/accounts/:id/message", to: "accounts#message", as: "message_account"
    post "/home/message", to: "home#message", as: "message_contact"
    post "/locations/:id/sensors", to: "locations#sensors", as: "sensors_location"
    get "/locations/:id/sensors", to: "locations#show_sensors", as: "show_sensors_location"

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
      resources :medias
      get "/gallery" => "medias#gallery"
    end

    post "login", to: "authentication#login"
    post "signup", to: "authentication#signup"
    post "validate_jwt_token", to: "authentication#validate_jwt_token"

    match "/404", to: "errors#not_found", via: :all
    match "/500", to: "errors#internal_server_error", via: :all
    match "/422", to: "errors#unprocessable_entity", via: :all

    scope(accounts: {}) do
      resources :accounts, path: "usuarios"
      resources :accounts, path: "contributors"
    end

    scope(locations: {}) do
      resources :locations, path: "locais"
      resources :locations, path: "l"
    end

    scope(practices: {}) do
      resources :practices, path: "agroecological-experiences"
      resources :practices, path: "experiencia_agroecologicas"
      resources :practices, path: "agroforestry"
      resources :practices, path: "experiences"
      resources :practices, path: "safs"
      resources :practices, path: "news"
    end
  end
end
