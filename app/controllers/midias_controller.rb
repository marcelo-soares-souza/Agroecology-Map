class MidiasController < ApplicationController
  before_action :set_midia, only: [:show, :edit, :update, :destroy]

  # GET /midias
  # GET /midias.json
  def index
    if params[:saf_id]
      @saf = Saf.friendly.find(params[:saf_id])
      @midias = Midia.where(:saf_id => @saf.id)
    elsif params[:experiencia_agroecologica_id]
      @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
      @midias = Midia.where(:experiencia_agroecologica_id => @experiencia_agroecologica.id)
    end
  end

  # GET /midias/1
  # GET /midias/1.json
  def show
    if params[:saf_id]
      @saf = Saf.friendly.find(params[:saf_id])
    elsif params[:experiencia_agroecologica_id]
      @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
    end
  end

  # GET /midias/new
  def new
    @midia = Midia.new

    if params[:saf_id]
      @saf = Saf.friendly.find(params[:saf_id])
    elsif params[:experiencia_agroecologica_id]
      @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
    end
  end

  # GET /midias/1/edit
  def edit
    if params[:saf_id]
      @saf = Saf.friendly.find(params[:saf_id])
    elsif params[:experiencia_agroecologica_id]
      @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
    end
  end

  # POST /midias
  # POST /midias.json
  def create
    @midia = Midia.new(midia_params)
    @midia.usuario_id = current_usuario.id

    if params[:saf_id]
      @saf = Saf.friendly.find(params[:saf_id])
      @midia.saf_id = @saf.id
    elsif params[:experiencia_agroecologica_id]
      @experiencia_agroecologia = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
      @midia.experiencia_agroecologica_id = @experiencia_agroecologia.id
    end

    respond_to do |format|
      if @midia.save
        if params[:saf_id]
          format.html { redirect_to saf_midia_path(@saf, @midia), notice: 'Midia was successfully created.' }
        elsif params[:experiencia_agroecologica_id]
          format.html { redirect_to experiencia_agroecologia_midia_path(@experiencia_agroecologia, @midia), notice: 'Midia was successfully created.' }
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
    if params[:saf_id]
      @saf = Saf.friendly.find(params[:saf_id])
    elsif params[:experiencia_agroecologica_id]
      @experiencia_agroecologia = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
    end

    respond_to do |format|
      if @midia.update(midia_params)
        if params[:saf_id]
          format.html { redirect_to saf_midia_path(@saf, @midia), notice: 'Midia was successfully created.' }
        elsif params[:experiencia_agroecologica_id]
          format.html { redirect_to experiencia_agroecologia_midia_path(@experiencia_agroecologia, @midia), notice: 'Midia was successfully created.' }
        else
          format.html { redirect_to @midia, notice: 'Midia was successfully created.' }
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

    if params[:saf_id]
      @saf = Saf.friendly.find(params[:saf_id])
    elsif params[:experiencia_agroecologica_id]
      @experiencia_agroecologia = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
    end

    respond_to do |format|
      if params[:saf_id]
        format.html { redirect_to saf_midias_path(@saf), notice: 'Midia was successfully destroyed.' }
      elsif params[:experiencia_agroecologica_id]
        format.html { redirect_to experiencia_agroecologia_midias_path(@experiencia_agroecologia), notice: 'Midia was successfully destroyed.' }
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
end
