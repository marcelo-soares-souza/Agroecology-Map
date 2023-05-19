# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @locais = Local.all.includes(:experiencia_agroecologicas).load_async
  end
end
