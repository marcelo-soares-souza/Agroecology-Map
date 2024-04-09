# frozen_string_literal: true

class Location < ApplicationRecord
  paginates_per 10

  scope :by_name, -> (name) { where("locations.name ILIKE ?", "%#{name}%") }
  scope :by_farm_and_farming_system, -> (farm_and_farming_system) { where("locations.farm_and_farming_system ILIKE ?", "%#{farm_and_farming_system}%") }
  scope :by_farm_and_farming_system_complement, -> (farm_and_farming_system_complement) { where("locations.farm_and_farming_system_complement ILIKE ?", "%#{farm_and_farming_system_complement}%") }
  scope :by_country, -> (country) { where("locations.country ILIKE ?", "%#{country}%") }
  scope :by_continent, -> (continent) { where("locations.continent ILIKE ?", "%#{continent}%") }

  belongs_to :account

  has_many :practices, dependent: :destroy
  has_many :medias, dependent: :destroy
  has_many :documents, dependent: :destroy

  has_one_attached :photo do |attachable|
    attachable.variant :original, resize_to_limit: [1920, nil]
    attachable.variant :medium, resize_to_limit: [600, nil]
    attachable.variant :thumb, resize_to_limit: [300, nil]
  end

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates_length_of :name, minimum: 2, maximum: 255
  validates_length_of :description, minimum: 2, maximum: 8192, allow_blank: true
  validate :acceptable_photo

  before_save do
    self.name = name.strip
    self.description = description.strip if attribute_present?("description")
    self.farm_and_farming_system_complement.gsub!(/[\[\]"]/, "") if attribute_present?("farm_and_farming_system_complement")
    self.continent = ISO3166::Country[country.downcase].continent if attribute_present?("country")
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

    require "csv"
    def self.to_csv
      cols = column_names.map(&:clone)

      cols.delete("slug")
      cols.delete("account_id")
      cols.delete("created_at")
      cols.delete("updated_at")

      cols.push("total_of_practices")
      cols.push("responsible_for_information")
      cols.push("created_at")
      cols.push("updated_at")

      CSV.generate do |csv|
        csv << cols

        cols.delete("total_of_practices")
        cols.delete("responsible_for_information")
        cols.delete("created_at")
        cols.delete("updated_at")

        Location.all.joins(:account).order(:id).each do |location|
          vals = location.attributes.values_at(*cols).map(&:clone)
          vals.push(location.practices.count)
          vals.push(location.account.attributes["name"])
          vals.push(location.attributes["created_at"])
          vals.push(location.attributes["updated_at"])
          csv << vals
        end
      end
    end
end
