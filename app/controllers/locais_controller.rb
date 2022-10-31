# frozen_string_literal: true

class LocaisController < ApplicationController
  before_action :set_local, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action -> { check_owner Local.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]
  before_action :load_tipos # , except: %i[index show]
  before_action :load_hospedagens, except: %i[index show]
  before_action :load_usuario
  before_action :load_colaboradores, except: %i[index show]

  # GET /locais
  # GET /locais.json
  def index
    @locais = if params[:usuario_id]
      Local.where(usuario_id: @usuario.id).sort_by(&:updated_at).reverse
    else
      Local.all.sort_by(&:updated_at).reverse
    end
  end

  # GET /locais/1
  # GET /locais/1.json
  def show; end

  # GET /locais/new
  def new
    @local = Local.new
    @local.local_usuarios.build
  end

  # GET /locais/1/edit
  def edit
    @local.local_usuarios.build
  end

  # POST /locais
  # POST /locais.json
  def create
    @local = Local.new(local_params)

    @local.usuario_id = current_usuario.id unless current_usuario.admin?

    respond_to do |format|
      if @local.save
        format.html { redirect_to @local, notice: "Local foi cadastrado." }
        format.json { render :show, status: :created, location: @local }
      else
        format.html { render :new }
        format.json { render json: @local.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locais/1
  # PATCH/PUT /locais/1.json
  def update
    respond_to do |format|
      if @local.update(local_params)
        format.html { redirect_to @local, notice: "Local foi atualizado." }
        format.json { render :show, status: :ok, location: @local }
      else
        format.html { render :edit }
        format.json { render json: @local.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locais/1
  # DELETE /locais/1.json
  def destroy
    @local.destroy
    respond_to do |format|
      format.html { redirect_to locais_url, notice: "Local foi removido." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_local
      @local = Local.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def local_params
      params.require(:local).permit(:nome, :slug, :observacao, :latitude, :longitude, :usuario_id, :imagem, :tipo,
                                    :hospedagem, usuario_ids: [])
    end

    def load_tipos
      @tipos = {
        t(:settlement) => "Assentamento",
        t(:collective_property) => "Propriedade Coletiva",
        t(:public_property) => "Propriedade Pública (Governo)",
        t(:private_property) => "Propriedade Privada",
        t(:familiar) => "Familiar",
        t(:other) => "Outro"
      }
    end

    def load_hospedagens
      @hospedagens = { t(:upon_consultation) => "Mediante a Consulta",
                       t(:yes_query) => "Sim",
                       t(:no_query) => "Não" }
    end

    def load_colaboradores
      @usuarios = Usuario.all
    end

    def load_usuario
      @usuario = Usuario.friendly.find(params[:usuario_id]) if params[:usuario_id]
    end
end
