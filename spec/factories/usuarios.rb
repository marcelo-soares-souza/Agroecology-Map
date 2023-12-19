# frozen_string_literal: true

# FILEPATH: /home/marcelo/Development/Pessoal/agroecologymap/spec/factories/usuarios.rb
FactoryBot.define do
  factory :usuario do
    nome { "Agroecology Map" }
    email { "agroecology@agroecologymap.org" }
    password { "123456789" }
    password_confirmation { "123456789" }
    admin { "f" }
    confirmed_at { Time.now }
  end
end
