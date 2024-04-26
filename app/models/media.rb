# frozen_string_literal: true

class Media < ApplicationRecord
  paginates_per 8

  belongs_to :location, required: false
  belongs_to :practice, required: false
  belongs_to :account, required: false

  has_one_attached :photo do |attachable|
    attachable.variant :original, { resize_to_limit: [1920, nil], convert: :webp, saver: { subsample_mode: "on", strip: true, interlace: true, quality: 85 } }
    attachable.variant :medium, { resize_to_limit: [600, nil], convert: :webp, saver: { subsample_mode: "on", strip: true, interlace: true, quality: 85 } }
    attachable.variant :thumb, { resize_to_limit: [300, nil], convert: :webp, saver: { subsample_mode: "on", strip: true, interlace: true, quality: 85 } }
  end

  validates :photo, presence: true
  validate :acceptable_photo
  validates_length_of :description, maximum: 255, allow_blank: true

  before_save do
    self.description = description.strip if attribute_present?("description")
  end
  def acceptable_photo
    return unless photo.attached?

    unless photo.blob.byte_size <= 16.megabyte
      errors.add(:photo, "Size Limit is 16 Mb")
    end

    acceptable_types = ["image/jpeg", "image/png", "image/gif", "image/webp"]
    unless acceptable_types.include?(photo.content_type)
      errors.add(:photo, "must be a JPEG, PNG, GIF or WebP")
    end
  end
end
