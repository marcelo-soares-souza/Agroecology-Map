class Organizacao < ApplicationRecord
  belongs_to :tipo_organizacao
  belongs_to :usuario

  has_many :organizacao_locais, dependent: :destroy
  has_many :locais, through: :organizacao_locais
  accepts_nested_attributes_for :organizacao_locais, allow_destroy: true

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true

  protected
    def should_generate_new_friendly_id?
      nome_changed?
    end

end
