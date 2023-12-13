# frozen_string_literal: true

class ExperienciaAgroecologicasController < ApplicationController
  before_action :set_experiencia_agroecologica, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action lambda {
    check_owner ExperienciaAgroecologica.friendly.find(params[:id]).usuario_id
  }, only: %i[edit update destroy]

  before_action lambda {
    check_owner_or_collaborator(Local.friendly.find(params[:local_id]).usuario_id, Local.friendly.find(params[:local_id]).local_usuarios)
  }, only: %i[new]

  before_action :load_locais, except: %i[index show]
  before_action :load_tema_experiencia_agroecologicas # , except: %i[index show]
  before_action :load_local
  before_action :load_usuario
  before_action :load_likes_info, only: %i[show]

  # GET /experiencia_agroecologicas
  # GET /experiencia_agroecologicas.json
  def index
    @experiencia_agroecologicas = if params[:local_id]
      ExperienciaAgroecologica.where(local_id: @local.id).includes(:local, :midias, :likes, :comentarios, :tema_experiencia_agroecologica).load_async.sort_by(&:updated_at).reverse
    elsif params[:usuario_id]
      ExperienciaAgroecologica.where(usuario_id: @usuario.id).includes(:local, :midias, :likes, :comentarios, :tema_experiencia_agroecologica).load_async.sort_by(&:updated_at).reverse
    else
      ExperienciaAgroecologica.all.includes(:local, :midias, :likes, :comentarios, :tema_experiencia_agroecologica).load_async.sort_by(&:updated_at).reverse
    end
  end

  # GET /experiencia_agroecologicas/1
  # GET /experiencia_agroecologicas/1.json
  def show
    @comentar = Comentario.new
  end

  # GET /experiencia_agroecologicas/new
  def new
    @experiencia_agroecologica = ExperienciaAgroecologica.new
  end

  # GET /experiencia_agroecologicas/1/edit
  def edit; end

  # POST /experiencia_agroecologicas
  # POST /experiencia_agroecologicas.json
  def create
    @experiencia_agroecologica = ExperienciaAgroecologica.new(experiencia_agroecologica_params)

    @experiencia_agroecologica.usuario_id = current_usuario.id unless current_usuario.admin?

    respond_to do |format|
      if @experiencia_agroecologica.save
        format.html { redirect_to @experiencia_agroecologica, notice: "Experiência em Agroecologia foi cadastrada." }
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
        format.html { redirect_to @experiencia_agroecologica, notice: "Experiência em Agroecologia foi atualizada." }
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
      format.html { redirect_to experiencia_agroecologicas_url, notice: "Experiência em Agroecologia foi removida." }
      format.json { head :no_content }
    end
  end

  def like
    @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:id])
    Like.create(usuario_id: current_usuario.id, experiencia_agroecologica_id: @experiencia_agroecologica.id)
    redirect_to experiencia_agroecologica_path(@experiencia_agroecologica)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiencia_agroecologica
      @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiencia_agroecologica_params
      params.require(:experiencia_agroecologica).permit(:nome, :slug, :usuario_id, :local_id,
                                                        :tema_experiencia_agroecologica_id, :resumo, :observacao)
    end

    def load_tema_experiencia_agroecologicas
      # @tema_experiencia_agroecologicas = TemaExperienciaAgroecologica.all.load_async
      @tema_experiencia_agroecologicas = {
        t(:urban_agriculture) => 1,
        t(:food) => 2,
        t(:health_and_medicinal_plants) => 3,
        t(:rural_development) => 4,
        t(:local_development) => 5,
        t(:education) => 6,
        t(:agricultural_research_and_rural_extension) => 7,
        t(:management_of_water_resources) => 8,
        t(:certification) => 9,
        t(:marketing) => 10,
        t(:processing_and_processing_of_production) => 11,
        t(:seeds) => 12,
        t(:agroforestry_systems) => 13,
        t(:management_of_native_vegetation_and_agro_extractivism) => 14,
        t(:animal_husbandry_systems) => 15,
        t(:agricultural_production_system) => 16,
        t(:alternative_agriculture_currents) => 17,
        t(:management_of_pests__diseases_and_weeds) => 18,
        t(:soil_management) => 19,
        t(:access_to_land_agrarian_reform_and_agroecology) => 20,
        t(:relationship_with_the_markets) => 21,
        t(:others) => 22,
        t(:women_and_agroecology) => 23,
        t(:fruit_growing) => 24,
        t(:extractivism) => 25,
        t(:craftsmanship) => 26,
        t(:periurban_agriculture) => 27,
        t(:sovereignty_and_food_security) => 28,
        t(:biodiversity) => 29,
        t(:financing) => 30,
        t(:construction_of_agroecological_knowledge) => 31,
        t(:public_policies_with_an_agroecological_approach) => 32,
        t(:reforestation) => 33,
        t(:compost) => 34,
        t(:eco_tourism) => 35,
        t(:rural_tourism) => 36,
        t(:indigenous_agriculture) => 37
      }
    end

    def load_local
      @local = Local.friendly.find(params[:local_id]) if params[:local_id]
    end

    def load_usuario
      @usuario = Usuario.friendly.find(params[:usuario_id]) if params[:usuario_id]
    end
    def load_likes_info
      likes = @experiencia_agroecologica.likes.map { |like| like.usuario.nome }.join(", ")
      @likes_info = likes.empty? ? "Like Button" : likes
    end
end
