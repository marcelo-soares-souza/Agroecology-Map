class NovidadesController < ApplicationController
  def index
    @blogs = Blog.all.sort_by(&:updated_at).reverse
  end

  def show
  end
end
