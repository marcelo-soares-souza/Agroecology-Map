# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :load_locations, only: %i[index map reduced_map]

  def index
  end

  def map
  end

  def reduced_map
  end

  private

  def load_locations
    @locations = Location.where(hide_my_location: false)
                         .and(Location.where.not(latitude: nil))
                         .and(Location.where.not(longitude: nil))
                         .where(hide_my_location: false)
                         .with_attached_photo
  end
end
