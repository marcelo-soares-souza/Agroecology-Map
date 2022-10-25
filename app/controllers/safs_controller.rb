class SafsController < ApplicationController
  before_action :set_saf, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action -> { check_owner Saf.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]
  before_action :load_locais, except: %i[index show]
  before_action :load_plantas_animais, except: [:index]
  before_action :load_local

  # GET /safs
  # GET /safs.json
  def index
    @safs = if params[:local_id]
              Saf.where(local_id: @local.id).sort_by(&:updated_at).reverse
            else
              Saf.all.sort_by(&:updated_at).reverse
            end
  end

  # GET /safs/1
  # GET /safs/1.json
  def show; end

  # GET /safs/new
  def new
    @saf = Saf.new
    @saf.saf_plantas.build
    @saf.saf_animais.build
  end

  # GET /safs/1/edit
  def edit
    @saf.saf_plantas.build
    @saf.saf_animais.build
  end

  # POST /safs
  # POST /safs.json
  def create
    @saf = Saf.new(saf_params)

    @saf.usuario_id = current_usuario.id unless current_usuario.admin?

    respond_to do |format|
      if @saf.save
        format.html { redirect_to @saf, notice: 'SAF foi cadastrado.' }
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
        format.html { redirect_to @saf, notice: 'SAF foi atualizado.' }
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
      format.html { redirect_to safs_url, notice: 'SAF foi removido.' }
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
    params.require(:saf).permit(:nome, :slug, :objetivo, :produto_principal, :inicio, :fim, :area, :local_id,
                                :usuario_id, :observacao, planta_ids: [], animal_ids: [])
  end

  def load_plantas_animais
    @plantas = Planta.all
    @animais = Animal.all
  end

  def load_local
    @local = Local.friendly.find(params[:local_id]) if params[:local_id]
  end
end
