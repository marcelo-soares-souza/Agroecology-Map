# frozen_string_literal: true

class Comentario < ApplicationRecord
  belongs_to :experiencia_agroecologica, required: false
  belongs_to :local, required: false
  belongs_to :usuario

  validates :texto, presence: true

  extend FriendlyId
  friendly_id :texto, use: :slugged

  # validates :texto, presence: true, uniqueness: true

  def normalize_friendly_id(string)
    super[0..150]
  end

  protected
    def should_generate_new_friendly_id?
      texto_changed?
    end
end
