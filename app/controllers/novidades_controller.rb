# frozen_string_literal: true

class NovidadesController < ApplicationController
  def index
    @blogs = Blog.order("updated_at DESC").page(params[:page])
  end

  def show; end
end
