# frozen_string_literal: true

class Midia < ApplicationRecord
  paginates_per 20
  # before_save :concatenate_details
  belongs_to :saf, required: false
  belongs_to :experiencia_agroecologica, required: false
  belongs_to :local, required: false

  extend FriendlyId
  friendly_id :uuid, use: :slugged

  def uuid
    SecureRandom.uuid
  end

  # validates :descricao, presence: true, uniqueness: true
  # validates_length_of :descricao, minimum: 3

  validates :imagem, presence: true

  has_attached_file :imagem, styles: { original: "1440>", medium: "360x360>", thumb: "180x180>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :imagem, content_type: %r{\Aimage/.*\z}

  protected
  # def should_generate_new_friendly_id?
  #   descricao_changed?
  # end

  # def concatenate_details
  #  instant = Time.now.strftime("%Y-%m-%d %T")
  #  self.descricao = "#{descricao} (#{instant})"
  # end
end
