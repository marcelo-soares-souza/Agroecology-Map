# frozen_string_literal: true

class Blog < ApplicationRecord
  belongs_to :local, required: false
  belongs_to :usuario

  extend FriendlyId
  friendly_id :titulo, use: :slugged

  validates :titulo, presence: true, uniqueness: true
  validates :texto, presence: true

  has_rich_text :text

  protected
    def should_generate_new_friendly_id?
      titulo_changed?
    end
end
