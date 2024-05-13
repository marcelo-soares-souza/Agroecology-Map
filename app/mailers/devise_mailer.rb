# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  protected
    def subject_for(key)
      "[Agroecology Map] " + I18n.t(:"#{devise_mapping.name}_subject", scope: [:devise, :mailer, key],
             default: [:subject, key.to_s.humanize])
    end
end
