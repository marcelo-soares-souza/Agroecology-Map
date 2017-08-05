class HomeController < ApplicationController
  def index
    @locais = Local.all
  end
end
