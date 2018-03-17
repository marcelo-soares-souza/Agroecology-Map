class ExperienciaAgroecologicasController < ApplicationController
  before_action :set_experiencia_agroecologica, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, only: [:new, :edit, :update, :destroy]
  before_action -> { check_owner ExperienciaAgroecologica.friendly.find(params[:id]).usuario_id }, only: [:edit, :update, :destroy]
  before_action :load_locais, except: [:index, :show]
  before_action :load_tema_experiencia_agroecologicas, except: [:index, :show]

  # GET /experiencia_agroecologicas
  # GET /experiencia_agroecologicas.json
  def index
    @experiencia_agroecologicas = ExperienciaAgroecologica.all.sort_by(&:updated_at).reverse
  end

  # GET /experiencia_agroecologicas/1
  # GET /experiencia_agroecologicas/1.json
  def show
  end

  # GET /experiencia_agroecologicas/new
  def new
    @experiencia_agroecologica = ExperienciaAgroecologica.new
  end

  # GET /experiencia_agroecologicas/1/edit
  def edit
  end

  # POST /experiencia_agroecologicas
  # POST /experiencia_agroecologicas.json
  def create
    @experiencia_agroecologica = ExperienciaAgroecologica.new(experiencia_agroecologica_params)

    if ! current_usuario.admin?
      @experiencia_agroecologica.usuario_id = current_usuario.id
    end

    respond_to do |format|
      if @experiencia_agroecologica.save
        format.html { redirect_to @experiencia_agroecologica, notice: 'Experiência em Agroecologia foi cadastrada.' }
        format.json { render :show, status: :created, location: @experiencia_agroecologica }
      else
        format.html { render :new }
        format.json { render json: @experiencia_agroecologica.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiencia_agroecologicas/1
  # PATCH/PUT /experiencia_agroecologicas/1.json
  def update
    respond_to do |format|
      if @experiencia_agroecologica.update(experiencia_agroecologica_params)
        format.html { redirect_to @experiencia_agroecologica, notice: 'Experiência em Agroecologia foi atualizada.' }
        format.json { render :show, status: :ok, location: @experiencia_agroecologica }
      else
        format.html { render :edit }
        format.json { render json: @experiencia_agroecologica.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiencia_agroecologicas/1
  # DELETE /experiencia_agroecologicas/1.json
  def destroy
    @experiencia_agroecologica.destroy
    respond_to do |format|
      format.html { redirect_to experiencia_agroecologicas_url, notice: 'Experiência em Agroecologia foi removida.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiencia_agroecologica
      @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiencia_agroecologica_params
      params.require(:experiencia_agroecologica).permit(:nome, :slug, :usuario_id, :local_id, :tema_experiencia_agroecologica_id, :resumo, :observacao)
    end

    def load_tema_experiencia_agroecologicas
      @tema_experiencia_agroecologicas = TemaExperienciaAgroecologica.all
    end
end
