# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "contact@agroecologymap.org"
  layout "mailer"
end
