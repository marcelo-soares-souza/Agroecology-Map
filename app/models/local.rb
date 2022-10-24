class Local < ApplicationRecord
  belongs_to :usuario

  has_many :organizacao_locais, dependent: :nullify
  has_many :organizacoes, through: :organizacao_locais
  accepts_nested_attributes_for :organizacao_locais, allow_destroy: true

  has_many :safs, dependent: :destroy
  has_many :experiencia_agroecologicas, dependent: :destroy

  has_many :blogs, :dependent => :delete_all

  has_many :local_usuarios, dependent: :destroy
  has_many :usuarios, through: :local_usuarios
  accepts_nested_attributes_for :local_usuarios, allow_destroy: true

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true, uniqueness: true
  validates :tipo, presence: true

  def default_image_number
    rand(0..5)
  end

  has_attached_file :imagem,
                    styles: { medium: "360x360>",
                    thumb: "180x180>" },
                    :default_url => lambda { |a| "/assets/place_:style_#{a.instance.default_image_number}.png" }
  validates_attachment_content_type :imagem, content_type: /\Aimage\/.*\z/

  protected

  def should_generate_new_friendly_id?
    nome_changed?
  end
end
