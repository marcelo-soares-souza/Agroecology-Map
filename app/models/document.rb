# frozen_string_literal: true

class Document < ApplicationRecord
  paginates_per 15

  belongs_to :location, required: false
  belongs_to :practice, required: false
  belongs_to :account, required: false
  has_one_attached :file

  validates :file, presence: true
  validate :acceptable_file
  validates_length_of :description, minimum: 4, maximum: 200, allow_blank: true

  before_save do
    self.description = description.strip
  end

  def acceptable_file
    return unless file.attached?

    unless file.blob.byte_size <= 16.megabyte
      errors.add(:photo, "Size Limit is 16 Mb")
    end

    acceptable_types = ["application/pdf"]
    unless acceptable_types.include?(file.content_type)
      errors.add(:file, "must be a PDF")
    end
  end
end
