# frozen_string_literal: true

class Account < ApplicationRecord
  paginates_per 15

  has_many :documents, dependent: :destroy
  has_many :medias, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :practices, dependent: :destroy
  has_many :locations, dependent: :destroy

  has_one_attached :photo do |attachable|
    attachable.variant :original, resize_to_limit: [1920, nil]
    attachable.variant :medium, resize_to_limit: [600, nil]
    attachable.variant :thumb, resize_to_limit: [300, nil]
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates_length_of :name, minimum: 2, maximum: 255
  # validates :name, format: { with: /\w+ \w+/, message: "Inform Your First and Last Name" }
  validates :email, presence: true, uniqueness: true
  validates_length_of :about, minimum: 2, allow_blank: true
  validates_length_of :about, maximum: 2048
  validates :website, format: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true
  validate :acceptable_photo
  validates :i_agree_with_terms_and_conditions, acceptance: true

  before_save do
    self.name = name.strip.titleize
    self.email = email.strip.downcase
    self.about = about.strip unless !self.about
    self.website = website.strip.downcase unless !self.website
  end

  protected
    def should_generate_new_friendly_id?
      name_changed?
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
