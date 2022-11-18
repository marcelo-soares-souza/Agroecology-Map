# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "marcelo@agroecologymap.org"
  layout "mailer"
end
