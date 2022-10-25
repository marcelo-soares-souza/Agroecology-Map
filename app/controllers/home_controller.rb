# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @locais = Local.all
  end
end
