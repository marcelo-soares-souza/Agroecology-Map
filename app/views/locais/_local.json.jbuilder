# frozen_string_literal: true

json.id local.id
json.name local.nome
json.description local.observacao
json.latitude local.latitude
json.longitude local.longitude
json.type @tipos.key(local.tipo)
json.url local_url(local)
json.created_at local.created_at
json.updated_at local.updated_at
