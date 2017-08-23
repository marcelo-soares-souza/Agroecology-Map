class SafsController < ApplicationController
  before_action :set_saf, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, only: [:new, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] { check_owner Saf.friendly.find(params[:id]).usuario_id }
  before_action :load_locais, except: [:index, :show]

  # GET /safs
  # GET /safs.json
  def index
    @safs = Saf.all
  end

  # GET /safs/1
  # GET /safs/1.json
  def show
  end

  # GET /safs/new
  def new
    @saf = Saf.new
  end

  # GET /safs/1/edit
  def edit
  end

  # POST /safs
  # POST /safs.json
  def create
    @saf = Saf.new(saf_params)
    @saf.usuario_id = current_usuario.id

    respond_to do |format|
      if @saf.save
        format.html { redirect_to @saf, notice: 'Saf was successfully created.' }
        format.json { render :show, status: :created, location: @saf }
      else
        format.html { render :new }
        format.json { render json: @saf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /safs/1
  # PATCH/PUT /safs/1.json
  def update
    respond_to do |format|
      if @saf.update(saf_params)
        format.html { redirect_to @saf, notice: 'Saf was successfully updated.' }
        format.json { render :show, status: :ok, location: @saf }
      else
        format.html { render :edit }
        format.json { render json: @saf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /safs/1
  # DELETE /safs/1.json
  def destroy
    @saf.destroy
    respond_to do |format|
      format.html { redirect_to safs_url, notice: 'Saf was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saf
      @saf = Saf.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def saf_params
      params.require(:saf).permit(:nome, :slug, :objetivo, :produto_principal, :inicio, :fim, :area, :local_id, :usuario_id, :observacao)
    end

    def load_locais
      if current_usuario.admin?
        @locais = Local.all
      else
        @locais = Local.where(usuario_id: current_usuario.id)
      end
    end
end
