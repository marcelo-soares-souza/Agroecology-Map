# frozen_string_literal: true

class Midia < ApplicationRecord
  belongs_to :saf, required: false
  belongs_to :experiencia_agroecologica, required: false
  has_one :local, through: :experiencia_agroecologica

  extend FriendlyId
  friendly_id :descricao, use: :slugged

  validates :descricao, presence: true, uniqueness: true
  validates :imagem, presence: true

  has_attached_file :imagem, styles: { original: "1920x>", medium: "360x360>", thumb: "180x180>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :imagem, content_type: %r{\Aimage/.*\z}

  protected
    def should_generate_new_friendly_id?
      descricao_changed?
    end
end
