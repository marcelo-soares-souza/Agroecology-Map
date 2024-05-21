# frozen_string_literal: true

class MailJob
  include Sidekiq::Job

  def perform(*_args)
    from = '"Agroecology Map" <noreply@agroecologymap.org>'
    to = _args[0]
    subject = _args[1]
    body = _args[2]

    ActionMailer::Base.mail(from:, to:, subject:, body:).deliver
  end
end
