class TipoOrganizacoesController < ApplicationController
  before_action :set_tipo_organizacao, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, except: [:show]
  before_action :check_if_admin, only: [:index]
  before_action only: [:edit, :update, :destroy] { check_if_usuario_owner params[:id] }

  # GET /tipo_organizacoes
  # GET /tipo_organizacoes.json
  def index
    @tipo_organizacoes = TipoOrganizacao.all
  end

  # GET /tipo_organizacoes/1
  # GET /tipo_organizacoes/1.json
  def show
  end

  # GET /tipo_organizacoes/new
  def new
    @tipo_organizacao = TipoOrganizacao.new
  end

  # GET /tipo_organizacoes/1/edit
  def edit
  end

  # POST /tipo_organizacoes
  # POST /tipo_organizacoes.json
  def create
    @tipo_organizacao = TipoOrganizacao.new(tipo_organizacao_params)
    @tipo_organizacao.usuario_id = current_usuario.id

    respond_to do |format|
      if @tipo_organizacao.save
        format.html { redirect_to @tipo_organizacao, notice: 'Tipo organizacao was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_organizacao }
      else
        format.html { render :new }
        format.json { render json: @tipo_organizacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_organizacoes/1
  # PATCH/PUT /tipo_organizacoes/1.json
  def update
    respond_to do |format|
      if @tipo_organizacao.update(tipo_organizacao_params)
        format.html { redirect_to @tipo_organizacao, notice: 'Tipo organizacao was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_organizacao }
      else
        format.html { render :edit }
        format.json { render json: @tipo_organizacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_organizacoes/1
  # DELETE /tipo_organizacoes/1.json
  def destroy
    @tipo_organizacao.destroy
    respond_to do |format|
      format.html { redirect_to tipo_organizacoes_url, notice: 'Tipo organizacao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_organizacao
      @tipo_organizacao = TipoOrganizacao.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_organizacao_params
      params.require(:tipo_organizacao).permit(:nome, :slug, :usuario_id)
    end
end
