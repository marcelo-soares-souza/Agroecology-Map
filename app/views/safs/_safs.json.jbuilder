# frozen_string_literal: true

json.id saf.id
json.name saf.nome
json.location saf.local.nome
json.main_objective saf.objetivo
json.main_product saf.produto_principal
json.start_date saf.inicio
json.end_date saf.fim
json.responsible_for_information saf.usuario.nome
json.url saf_url(saf)
json.created_at saf.created_at
json.updated_at saf.updated_at
