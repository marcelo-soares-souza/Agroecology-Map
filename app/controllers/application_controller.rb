class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected
    def set_locale
      I18n.default_locale = "pt-BR"
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:nome])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:nome])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nome])
    end

    def check_owner(usuario_id)
      if signed_in?
        if ! current_usuario.admin? && current_usuario.id != (usuario_id)
          redirect_to root_url, alert: "Permissão Negada"
        end
      end
    end

    def check_if_admin
      if signed_in?
        if ! current_usuario.admin?
          redirect_to root_url, alert: "Permissão Negada"
        end
      end
    end

    def load_ufs
      @ufs = { "Acre" => "AC",
              "Alagoas" => "AL",
              "Amapá" => "AP",
              "Amazonas" => "AM",
              "Bahia" => "BA",
              "Ceará" => "CE",
              "Distrito Federal" => "DF",
              "Espírito Santo" => "ES",
              "Goiás" => "GO",
              "Maranhão" => "MA",
              "Mato Grosso" => "MT",
              "Mato Grosso do Sul" => "MS",
              "Minas Gerais" => "MG",
              "Pará" => "PA",
              "Paraíba" => "PB",
              "Paraná" => "PR",
              "Pernambuco" => "PE",
              "Piauí" => "PI",
              "Rio de Janeiro" => "RJ",
              "Rio Grande do Norte" => "RN",
              "Rio Grande do Sul" => "RS",
              "Rondônia" => "RO",
              "Roraima" => "RR",
              "Santa Catarina" => "SC",
              "São Paulo" => "SP",
              "Sergipe" => "SE",
              "Tocantins" => "TO"
             }
    end

    def load_locais
      if current_usuario.admin?
        @locais = Local.all
      else
        @locais = Local.where(usuario_id: current_usuario.id)
      end
    end
end
