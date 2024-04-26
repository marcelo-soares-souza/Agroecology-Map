# frozen_string_literal: true

class Accounts::SessionsController < Devise::SessionsController
  # prepend_before_action :check_captcha, only: %i[create]

  private
    def check_captcha
      alert_recaptcha unless verify_recaptcha
    end

    def alert_recaptcha
      self.resource = resource_class.new sign_in_params
      respond_with_navigational(resource) { render :new }
    end
end
