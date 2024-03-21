# frozen_string_literal: true

class WhatYouDo < ApplicationRecord
  belongs_to :practice
  validates :practice, presence: true
end
