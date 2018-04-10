class Blog < ApplicationRecord
  belongs_to :local, required: false

  extend FriendlyId
  friendly_id :titulo, use: :slugged

  validates :titulo, presence: true, uniqueness: true
  validates :texto, presence: true

  protected
    def should_generate_new_friendly_id?
      titulo_changed?
    end
end
