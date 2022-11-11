# frozen_string_literal: true

class MidiasController < ApplicationController
  before_action :set_midia, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action -> { check_owner Midia.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]
  before_action :load_dados

  # GET /midias
  # GET /midias.json
  def index
    if params[:saf_id]
      @midias = Midia.where(saf_id: @saf.id)
    elsif params[:experiencia_agroecologica_id]
      @midias = Midia.where(experiencia_agroecologica_id: @experiencia_agroecologica.id)
    end
  end

  # GET /gallery
  # GET /gallery.json
  def gallery
    if params[:saf_id]
      @midias = Midia.where(saf_id: @saf.id)
    elsif params[:experiencia_agroecologica_id]
      @midias = Midia.where(experiencia_agroecologica_id: @experiencia_agroecologica.id)
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
    end

    respond_to do |format|
      if @midia.save
        if params[:saf_id]
          format.html { redirect_to saf_midia_path(@saf, @midia), notice: "Midia foi cadastrada." }
        elsif params[:experiencia_agroecologica_id]
          format.html do
            redirect_to experiencia_agroecologica_midia_path(@experiencia_agroecologica, @midia),
                        notice: "Midia foi cadastrada."
          end
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
          format.html { redirect_to saf_midia_path(@saf, @midia), notice: "Midia foi atualizada." }
        elsif params[:experiencia_agroecologica_id]
          format.html do
            redirect_to experiencia_agroecologica_midia_path(@experiencia_agroecologica, @midia),
                        notice: "Midia foi atualizada"
          end
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
        format.html { redirect_to saf_midias_path(@saf), notice: "Midia foi removida." }
      elsif params[:experiencia_agroecologica_id]
        format.html do
          redirect_to experiencia_agroecologica_midias_path(@experiencia_agroecologica), notice: "Midia foi removida."
        end
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
      params.require(:midia).permit(:descricao, :slug, :saf_id, :experiencia_agroecologica_id, :imagem, :usuario_id)
    end

    def load_dados
      if params[:saf_id]
        @saf = Saf.friendly.find(params[:saf_id])
      elsif params[:experiencia_agroecologica_id]
        @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
      end
    end
end
