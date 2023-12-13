# frozen_string_literal: true

class ComentariosController < ApplicationController
  before_action :set_comentario, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action -> { check_owner Comentario.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]

  # POST /comentarios
  # POST /comentarios.json
  def create
    @comentario = Comentario.new(comentario_params)

    if params[:experiencia_agroecologica_id]
      @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
      @comentario.experiencia_agroecologica_id = @experiencia_agroecologica.id
      @name = @experiencia_agroecologica.nome
      @email = @experiencia_agroecologica.usuario.email
      @redirect = @experiencia_agroecologica
    elsif params[:local_id]
      @local = Local.friendly.find(params[:local_id])
      @comentario.local_id = @local.id
      @name = @local.nome
      @email = @local.usuario.email
      @redirect = @local
    end

    # if ! current_usuario.admin?
    @comentario.usuario_id = current_usuario.id
    # end

    respond_to do |format|
      if @comentario.save
        subject = "[Agroecology Map] You have received a new comment on #{@name}"
        body = "Comment: #{@comentario.texto}"

        if @redirect.usuario.id != current_usuario.id
          ActionMailer::Base.mail(from: "Agroecology Map <marcelo@agroecologymap.org>",
                                  to: @email,
                                  subject:,
                                  body:).deliver
        end

        format.html { redirect_to @redirect, notice: "Comentário foi registrado." }
      else
        format.html { redirect_to @redirect, notice: "Não foi possível registrar o comentário" }
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.json
  def destroy
    if @comentario.experiencia_agroecologica_id
      @type = ExperienciaAgroecologica.find(@comentario.experiencia_agroecologica_id)
    elsif @comentario.local_id
      @type = Local.find(@comentario.local_id)
    end

    @comentario.destroy
    respond_to do |format|
      format.html { redirect_to @type, notice: "Comentário foi removido." }
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
