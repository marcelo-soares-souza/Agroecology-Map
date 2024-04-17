# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :location, required: false
  belongs_to :practice, required: false
  belongs_to :account

  validates :account_id, uniqueness: { scope: [:location_id, :practice_id] }
end
