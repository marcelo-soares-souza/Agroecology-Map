# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @location_by_country = Local.group(:country).count
  end
end
