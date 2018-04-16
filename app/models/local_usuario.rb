class LocalUsuario < ApplicationRecord
  belongs_to :local
  belongs_to :usuario
  accepts_nested_attributes_for :local, allow_destroy: true
end
