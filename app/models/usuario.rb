class Usuario < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  extend FriendlyId
  friendly_id :nome, use: :slugged

  validates :nome, presence: true

  def should_generate_new_friendly_id?
    nome_changed?
  end
end
