# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :usuario
  belongs_to :experiencia_agroecologica, required: false
  belongs_to :local, required: false

  validates :usuario_id, uniqueness: { scope: [:experiencia_agroecologica_id, :local_id] }
end
