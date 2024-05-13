# frozen_string_literal: true

class Acknowledge < ApplicationRecord
  belongs_to :practice
  validates :practice, presence: true

  before_save do
    self.knowledge_source.gsub!(/[\[\]"]/, "") if attribute_present?("knowledge_source")
  end
end
