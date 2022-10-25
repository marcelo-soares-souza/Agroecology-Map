# frozen_string_literal: true

json.extract! local, :id, :nome, :observacao, :latitude, :longitude, :tipo, :hospedagem, :created_at, :updated_at
json.url local_url(local, format: :json)
