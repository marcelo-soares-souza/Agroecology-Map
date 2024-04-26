# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  def index
  end

  def map
    @locations = Location.where(hide_my_location: false)
  end
end
