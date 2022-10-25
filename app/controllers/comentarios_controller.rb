class ComentariosController < ApplicationController
  before_action :set_comentario, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action -> { check_owner Comentario.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]

  # POST /comentarios
  # POST /comentarios.json
  def create
    @comentario = Comentario.new(comentario_params)
    @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
    @comentario.experiencia_agroecologica_id = @experiencia_agroecologica.id

    # if ! current_usuario.admin?
    @comentario.usuario_id = current_usuario.id
    # end

    respond_to do |format|
      if @comentario.save
        format.html { redirect_to @experiencia_agroecologica, notice: 'Comentário foi registrado.' }
      else
        format.html { redirect_to @experiencia_agroecologica, notice: 'Não foi possível registrar o comentário' }
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.json
  def destroy
    @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(@comentario.experiencia_agroecologica_id)

    @comentario.destroy
    respond_to do |format|
      format.html { redirect_to @experiencia_agroecologica, notice: 'Comentário foi removido.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comentario
    @comentario = Comentario.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comentario_params
    params.require(:comentario).permit(:texto, :slug, :usuario_id, :experiencia_agroecologica_id)
  end
end
