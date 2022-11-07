# frozen_string_literal: true

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular "tipo_organizacao", "tipo_organizacoes"
  inflect.irregular "organizacao", "organizacoes"
  inflect.irregular "local", "locais"
  inflect.irregular "planta", "plantas"
  inflect.irregular "animal", "animais"
  inflect.irregular "midia", "midias"
  inflect.irregular "comentario", "comentarios"
  inflect.irregular "friend", "friends"
end
