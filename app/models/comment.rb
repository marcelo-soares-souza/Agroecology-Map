# frozen_string_literal: true

class Comment < ApplicationRecord
  paginates_per 5

  belongs_to :account
  belongs_to :practice

  validates_length_of :comment, maximum: 4096
end
