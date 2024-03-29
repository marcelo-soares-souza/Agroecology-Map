# frozen_string_literal: true

class Usuario < ApplicationRecord
  has_many :tema_experiencia_agroecologicas
  has_many :tipo_organizacoes
  has_many :usuarios
  has_many :locais
  has_many :organizacoes
  has_many :safs
  has_many :experiencia_agroecologicas
  has_many :plantas
  has_many :animais
  has_many :local_usuarios, dependent: :destroy
  has_many :colaboracoes, through: :local_usuarios, source: :local
  has_many :likes
  has_many :comentarios

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true

  validates_length_of :about, minimum: 4, allow_blank: true
  validates_length_of :about, maximum: 4096
  validates :website, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true

  before_save do
    self.nome = nome.strip.titleize
    self.email = email.strip.downcase
    self.about = about.strip unless !self.about
    self.website = website.strip.downcase unless !self.website
  end


  def default_image_number
    # rand(1..9)
    id.to_s.last
  end

  has_attached_file :imagem,
                    styles: { original: "1920x>", medium: "360x360>", thumb: "180x180>" },
                    default_url: ->(a) { "/assets/avatar_:style_#{a.instance.default_image_number}.png" }
  validates_attachment_content_type :imagem, content_type: %r{\Aimage/.*\z}

  protected
    def should_generate_new_friendly_id?
      nome_changed?
    end
end
