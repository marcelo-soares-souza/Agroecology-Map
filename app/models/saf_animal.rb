# frozen_string_literal: true

class SafAnimal < ApplicationRecord
  belongs_to :saf
  belongs_to :animal
  accepts_nested_attributes_for :saf, allow_destroy: true
end
