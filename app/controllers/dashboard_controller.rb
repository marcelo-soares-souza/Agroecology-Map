# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    locations = Local.all

    @countries = Hash.new(0)
    locations.each do |location|
      @countries[location.country] += 1
    end
  end
end
