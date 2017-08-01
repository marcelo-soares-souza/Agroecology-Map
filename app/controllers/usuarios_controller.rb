class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!, except: [:show]
  before_action :check_if_admin, only: [:index]
  before_action only: [:edit, :update, :destroy] { check_if_usuario_owner params[:id] }

  def index
    @usuarios = Usuario.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to @usuario, notice: "Usuário foi atualizado." }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { render :edit }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @usuario.destroy
    respond_to do |format|
      format.html { redirect_to sistemas_url, notice: "Usuário foi removido." }
      format.json { head :no_content }
    end
  end

  private
    def set_usuario
      @usuario = Usuario.friendly.find(params[:id])
    end

    def usuario_params
      params.require(:usuario).permit(:id, :email, :nome, :slug, :imagem)
    end
end
