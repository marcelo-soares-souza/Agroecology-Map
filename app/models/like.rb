class Like < ApplicationRecord
  belongs_to :usuario
  belongs_to :experiencia_agroecologica

  validates :usuario_id, uniqueness: { scope: :experiencia_agroecologica_id }
end
