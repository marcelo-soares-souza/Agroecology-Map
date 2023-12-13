# frozen_string_literal: true

class MidiasController < ApplicationController
  before_action :set_midia, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action -> { check_owner Midia.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]
  before_action :load_dados
  before_action :selected_id
  before_action :default_media_name

  # GET /midias
  # GET /midias.json
  def index
    if params[:saf_id]
      @midias = Midia.where(saf_id: @saf.id).load_async.sort_by(&:updated_at).reverse
    elsif params[:experiencia_agroecologica_id]
      @midias = Midia.where(experiencia_agroecologica_id: @experiencia_agroecologica.id).load_async.sort_by(&:updated_at).reverse
    elsif params[:local_id]
      @midias = Midia.where(local_id: @local.id).load_async.sort_by(&:updated_at).reverse
    end
  end

  # GET /gallery
  # GET /gallery.json
  def gallery
    if params[:saf_id]
      @midias = Midia.where(saf_id: @saf.id).load_async.sort_by(&:updated_at).reverse
    elsif params[:experiencia_agroecologica_id]
      @midias = Midia.where(experiencia_agroecologica_id: @experiencia_agroecologica.id).load_async.sort_by(&:updated_at).reverse
    elsif params[:local_id]
      local = Local.friendly.find(params[:local_id])
      experiencia_agroecologica = ExperienciaAgroecologica.where(local_id: local.id).load_async.sort_by(&:updated_at).reverse
      saf = Saf.where(local_id: local.id).load_async.sort_by(&:updated_at).reverse
      @midias = Midia.where(experiencia_agroecologica:).load_async.sort_by(&:updated_at).reverse
      @midias += Midia.where(saf:).load_async.sort_by(&:updated_at).reverse
      @midias += Midia.where(local_id: local.id).load_async.sort_by(&:updated_at).reverse
    end
  end

  # GET /midias/1
  # GET /midias/1.json
  def show; end

  # GET /midias/new
  def new
    @midia = Midia.new
  end

  # GET /midias/1/edit
  def edit; end

  # POST /midias
  # POST /midias.json
  def create
    @midia = Midia.new(midia_params)

    @midia.usuario_id = current_usuario.id unless current_usuario.admin?

    if params[:saf_id]
      @midia.saf_id = @saf.id
    elsif params[:experiencia_agroecologica_id]
      @midia.experiencia_agroecologica_id = @experiencia_agroecologica.id
    elsif params[:local_id]
      @midia.local_id = @local.id
    end

    respond_to do |format|
      if @midia.save
        if params[:saf_id]
          format.html { redirect_to saf_gallery_path(@saf, @midia), notice: "Photo was Added." }
        elsif params[:experiencia_agroecologica_id]
          format.html { redirect_to experiencia_agroecologica_gallery_path(@experiencia_agroecologica, @midia), notice: "Photo was Added." }
        elsif params[:local_id]
          format.html { redirect_to local_gallery_path(@local, @midia), notice: "Photo was Added." }
        end
        format.json { render :show, status: :created, location: @midia }
      else
        format.html { render :new }
        format.json { render json: @midia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /midias/1
  # PATCH/PUT /midias/1.json
  def update
    respond_to do |format|
      if @midia.update(midia_params)
        if params[:saf_id]
          format.html { redirect_to saf_gallery_path(@saf, @midia), notice: "Photo was Updated." }
        elsif params[:experiencia_agroecologica_id]
          format.html { redirect_to experiencia_agroecologica_gallery_path(@experiencia_agroecologica, @midia), notice: "Photo was Updated" }
        elsif params[:local_id]
          format.html { redirect_to local_gallery_path(@local, @midia), notice: "Photo was Updated" }
        end
        format.json { render :show, status: :ok, location: @midia }
      else
        format.html { render :edit }
        format.json { render json: @midia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /midias/1
  # DELETE /midias/1.json
  def destroy
    @midia.destroy

    respond_to do |format|
      if params[:saf_id]
        format.html { redirect_to saf_gallery_path(@saf), notice: "Photo was removed." }
      elsif params[:experiencia_agroecologica_id]
        format.html { redirect_to experiencia_agroecologica_gallery_path(@experiencia_agroecologica), notice: "Photo was removed." }
      elsif params[:local_id]
        format.html { redirect_to local_gallery_path(@local), notice: "Photo was removed." }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_midia
      @midia = Midia.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def midia_params
      params.require(:midia).permit(:descricao, :slug, :saf_id, :experiencia_agroecologica_id, :local_id, :imagem, :usuario_id)
    end

    def load_dados
      if params[:saf_id]
        @saf = Saf.friendly.find(params[:saf_id])
      elsif params[:experiencia_agroecologica_id]
        @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
      elsif params[:local_id]
        @local = Local.friendly.find(params[:local_id])
      end
    end

    def selected_id
      if current_usuario && current_usuario.admin?
        @selected_id = current_usuario.id
        if @experiencia_agroecologica
          @selected_id = @experiencia_agroecologica.usuario.id
        elsif @saf
          @selected_id = @saf.usuario.id
        elsif @local
          @selected_id = @local.usuario.id
        end
      end
    end

    def default_media_name
      if current_usuario && current_usuario.admin?
        @default_media_name = ""
        if @experiencia_agroecologica
          @default_media_name = @experiencia_agroecologica.nome + " "
        elsif @saf
          @default_media_name = @saf.nome + " "
        elsif @local
          @default_media_name = @local.nome + " "
        end
      end
    end
end
