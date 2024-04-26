# frozen_string_literal: true

class Characterise < ApplicationRecord
  belongs_to :practice
  validates :practice, presence: true

  before_save do
    self.agroecology_principles_addressed.gsub!(/[\[\]"]/, "") if attribute_present?("agroecology_principles_addressed")
  end

  before_save do
    self.food_system_components_addressed.gsub!(/[\[\]"]/, "") if attribute_present?("food_system_components_addressed")
  end
end
