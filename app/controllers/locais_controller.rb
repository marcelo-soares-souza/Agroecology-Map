class LocaisController < ApplicationController
  before_action :set_local, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, only: [:new, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] { check_owner Local.friendly.find(params[:id]).usuario_id }

  # GET /locais
  # GET /locais.json
  def index
    @locais = Local.all
  end

  # GET /locais/1
  # GET /locais/1.json
  def show
  end

  # GET /locais/new
  def new
    @local = Local.new
  end

  # GET /locais/1/edit
  def edit
  end

  # POST /locais
  # POST /locais.json
  def create
    @local = Local.new(local_params)
    @local.usuario_id = current_usuario.id

    respond_to do |format|
      if @local.save
        format.html { redirect_to @local, notice: 'Local foi cadastrado.' }
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
        format.html { redirect_to @local, notice: 'Local foi atualizado.' }
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
      format.html { redirect_to locais_url, notice: 'Local foi removido.' }
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
      params.require(:local).permit(:nome, :slug, :observacao, :latitude, :longitude, :usuario_id, :imagem)
    end
end
