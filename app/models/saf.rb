class Saf < ApplicationRecord
  belongs_to :local
  belongs_to :usuario
  has_one :organizacao, through: :local
  has_many :midias, dependent: :delete_all

  has_many :saf_plantas, dependent: :destroy
  has_many :plantas, through: :saf_plantas
  accepts_nested_attributes_for :saf_plantas, allow_destroy: true

  has_many :saf_animais, dependent: :destroy
  has_many :animais, through: :saf_animais
  accepts_nested_attributes_for :saf_animais, allow_destroy: true

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true, uniqueness: true
  validates :local, presence: true

  protected

  def should_generate_new_friendly_id?
    nome_changed?
  end
end
