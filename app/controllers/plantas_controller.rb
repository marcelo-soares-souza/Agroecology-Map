# frozen_string_literal: true

class PlantasController < ApplicationController
  before_action :set_planta, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action -> { check_owner Planta.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]

  # GET /plantas
  # GET /plantas.json
  def index
    @plantas = Planta.all.load_async.sort_by(&:updated_at).reverse
  end

  # GET /plantas/1
  # GET /plantas/1.json
  def show; end

  # GET /plantas/new
  def new
    @planta = Planta.new
  end

  # GET /plantas/1/edit
  def edit; end

  # POST /plantas
  # POST /plantas.json
  def create
    @planta = Planta.new(planta_params)

    @planta.usuario_id = current_usuario.id unless current_usuario.admin?

    respond_to do |format|
      if @planta.save
        format.html { redirect_to @planta, notice: "Planta foi cadastrada." }
        format.json { render :show, status: :created, location: @planta }
      else
        format.html { render :new }
        format.json { render json: @planta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plantas/1
  # PATCH/PUT /plantas/1.json
  def update
    respond_to do |format|
      if @planta.update(planta_params)
        format.html { redirect_to @planta, notice: "Planta foi atualizada." }
        format.json { render :show, status: :ok, location: @planta }
      else
        format.html { render :edit }
        format.json { render json: @planta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plantas/1
  # DELETE /plantas/1.json
  def destroy
    @planta.destroy
    respond_to do |format|
      format.html { redirect_to plantas_url, notice: "Planta foi removida." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planta
      @planta = Planta.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def planta_params
      params.require(:planta).permit(:nome, :slug, :nome_cientifico, :observacao, :usuario_id, :imagem)
    end
end
