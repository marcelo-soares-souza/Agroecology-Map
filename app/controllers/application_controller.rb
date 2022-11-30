# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected
    def set_locale
      default_locale = "pt-BR"

      if request.host == "agroecologymap.org"
        default_locale = "en"
      end

      I18n.default_locale = default_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale] = I18n.locale
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:nome])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:nome])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nome])
    end

    def check_owner(usuario_id)
      if signed_in? && (!current_usuario.admin? && current_usuario.id != (usuario_id))
        redirect_to root_url, alert: "Permissão Negada"
      end
    end

    def check_owner_or_collaborator(usuario_id, collaborators)
      if signed_in? && (!current_usuario.admin? && current_usuario.id != usuario_id && !collaborators.collect(&:usuario_id).include?(current_usuario.id))
        redirect_to root_url, alert: "Permissão Negada"
      end
    end

    def check_if_admin
      redirect_to root_url, alert: "Permissão Negada" if signed_in? && !current_usuario.admin?
    end

    def load_locais
      @locais = if current_usuario.admin?
        Local.all.load_async
      else
        Local.where(usuario_id: current_usuario.id).load_async
      end
    end

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:usuario, request.fullpath)
    end
end
