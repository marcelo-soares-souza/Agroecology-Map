class Planta < ApplicationRecord
  belongs_to :usuario

  has_many :saf_plantas, dependent: :destroy
  has_many :safs, through: :saf_plantas

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true, uniqueness: true

  has_attached_file :imagem, styles: { medium: "360x360>", thumb: "180x180>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\z/

  protected
    def should_generate_new_friendly_id?
      nome_changed?
    end
end
