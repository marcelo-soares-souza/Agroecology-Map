# frozen_string_literal: true

class NovidadesController < ApplicationController
  def index
    @blogs = Blog.all.load_async.sort_by(&:updated_at).reverse
  end

  def show; end
end
