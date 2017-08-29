class Usuario < ApplicationRecord
  has_many :tema_experiencia_agroecologicas
  has_many :tipo_organizacoes
  has_many :usuarios
  has_many :locais
  has_many :organizacoes
  has_many :safs
  has_many :experiencia_agroecologicas

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true

  has_attached_file :imagem, styles: { medium: "360x360>", thumb: "180x180>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\z/

  protected
    def should_generate_new_friendly_id?
      nome_changed?
    end
end
