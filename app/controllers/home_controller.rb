# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :authenticate_account!, only: %i[message]

  before_action :load_locations, only: %i[index map reduced_map]

  def index
  end

  def map
  end

  def reduced_map
  end

  def message
    email = params["contact"]["email"]
    message = params["contact"]["message"]

    if not message.nil?
      to = "marcelo@agroecologymap.org"
      subject = "[Agroecology Map] #{email} sent you a message"
      body = "Message: #{message}"
      body += "\r\n \r\n"

      MailJob.perform_async(to, subject, body)
    end

    respond_to do |format|
      format.html { redirect_to contact_path, notice: "A message was sent to Agroecology Map" }
    end
  end

  private
    def load_locations
      @locations = Location.where(hide_my_location: false)
                           .and(Location.where.not(latitude: nil))
                           .and(Location.where.not(longitude: nil))
                           .where(hide_my_location: false)
                           .with_attached_photo
    end
end
