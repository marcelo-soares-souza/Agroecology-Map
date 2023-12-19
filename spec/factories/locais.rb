# frozen_string_literal: true

# FILEPATH: /home/marcelo/Development/Pessoal/agroecologymap/spec/factories/locais.rb
FactoryBot.define do
  factory :local do
    nome { "My Little Garden" }
    observacao { "My Permaculture Garden" }
    tipo { "Other" }
  end
end
