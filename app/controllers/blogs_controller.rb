# frozen_string_literal: true

class BlogsController < ApplicationController
  before_action :set_blog, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action lambda {
    check_owner_or_collaborator(Local.friendly.find(params[:local_id]).usuario_id, Local.friendly.find(params[:local_id]).local_usuarios)
  }, only: %i[new edit update destroy]
  before_action :load_dados

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.where(local_id: @local.id).load_async.sort_by(&:updated_at).reverse
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show; end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit; end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    @blog.usuario_id = current_usuario.id unless current_usuario.admin?

    @blog.local_id = @local.id

    respond_to do |format|
      if @blog.save
        format.html { redirect_to local_blog_path(@local, @blog), notice: "Blog foi cadastrada." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to local_blog_path(@local, @blog), notice: "Blog foi atualizada." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to local_blogs_path(@local), notice: "Blog foi removida." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:titulo, :slug, :texto, :local_id, :usuario_id, :tag_list)
    end

    def load_dados
      @local = Local.friendly.find(params[:local_id])
    end
end
