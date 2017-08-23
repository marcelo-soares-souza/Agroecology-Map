class Saf < ApplicationRecord
  belongs_to :local
  belongs_to :usuario
  has_one :organizacao, through: :local

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true
  validates :local, presence: true

  protected
    def should_generate_new_friendly_id?
      nome_changed?
    end
end
