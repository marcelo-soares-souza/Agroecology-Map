# frozen_string_literal: true

class Evaluate < ApplicationRecord
  belongs_to :practice
  validates :practice, presence: true
end
