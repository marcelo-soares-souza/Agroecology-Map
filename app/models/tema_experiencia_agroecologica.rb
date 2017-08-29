class TemaExperienciaAgroecologica < ApplicationRecord
  belongs_to :usuario

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true, uniqueness: true

  protected
    def should_generate_new_friendly_id?
      nome_changed?
    end
end
