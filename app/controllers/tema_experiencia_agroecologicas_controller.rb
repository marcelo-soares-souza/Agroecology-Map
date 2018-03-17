class TemaExperienciaAgroecologicasController < ApplicationController
  before_action :set_tema_experiencia_agroecologica, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, except: [:show]
  before_action :check_if_admin, only: [:index]
  before_action -> { check_owner TemaExperienciaAgroecologica.friendly.find(params[:id]).usuario_id }, only: [:edit, :update, :destroy]

  # GET /tema_experiencia_agroecologicas
  # GET /tema_experiencia_agroecologicas.json
  def index
    @tema_experiencia_agroecologicas = TemaExperienciaAgroecologica.all.sort_by(&:updated_at).reverse
  end

  # GET /tema_experiencia_agroecologicas/1
  # GET /tema_experiencia_agroecologicas/1.json
  def show
  end

  # GET /tema_experiencia_agroecologicas/new
  def new
    @tema_experiencia_agroecologica = TemaExperienciaAgroecologica.new
  end

  # GET /tema_experiencia_agroecologicas/1/edit
  def edit
  end

  # POST /tema_experiencia_agroecologicas
  # POST /tema_experiencia_agroecologicas.json
  def create
    @tema_experiencia_agroecologica = TemaExperienciaAgroecologica.new(tema_experiencia_agroecologica_params)

    if ! current_usuario.admin?
      @tema_experiencia_agroecologica.usuario_id = current_usuario.id
    end

    respond_to do |format|
      if @tema_experiencia_agroecologica.save
        format.html { redirect_to @tema_experiencia_agroecologica, notice: 'Tema da Experiência Agroecológica foi cadastrada.' }
        format.json { render :show, status: :created, location: @tema_experiencia_agroecologica }
      else
        format.html { render :new }
        format.json { render json: @tema_experiencia_agroecologica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tema_experiencia_agroecologicas/1
  # PATCH/PUT /tema_experiencia_agroecologicas/1.json
  def update
    respond_to do |format|
      if @tema_experiencia_agroecologica.update(tema_experiencia_agroecologica_params)
        format.html { redirect_to @tema_experiencia_agroecologica, notice: 'Tema da Experiência Agroecológica foi atualizada.' }
        format.json { render :show, status: :ok, location: @tema_experiencia_agroecologica }
      else
        format.html { render :edit }
        format.json { render json: @tema_experiencia_agroecologica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tema_experiencia_agroecologicas/1
  # DELETE /tema_experiencia_agroecologicas/1.json
  def destroy
    @tema_experiencia_agroecologica.destroy
    respond_to do |format|
      format.html { redirect_to tema_experiencia_agroecologicas_url, notice: 'Tema da Experiência Agroecológica foi removida.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tema_experiencia_agroecologica
      @tema_experiencia_agroecologica = TemaExperienciaAgroecologica.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tema_experiencia_agroecologica_params
      params.require(:tema_experiencia_agroecologica).permit(:nome, :slug, :usuario_id)
    end
end
