class NovidadesController < ApplicationController
  def index
    @blogs = Blog.all.sort_by(&:created_at).reverse
  end

  def show
  end
end
