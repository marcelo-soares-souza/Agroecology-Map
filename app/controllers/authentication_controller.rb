# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate

  def signup
    name = params[:name]
    email = params[:email]
    password = params[:password]

    @account = Account.new(name:, email:, password:, password_confirmation: password, bypass_humanizer: true)

    respond_to do |format|
      if @account.save
        format.json { render json: { message: "created" }, status: :created }
      else
        format.json { render json: { error: @account.errors }, status: :unprocessable_entity }
      end
    end
  end

  def login
    account = Account.find_by(email: params[:email])
    isValid = account.valid_password?(params[:password]) unless account.nil?

    if isValid
      token = JsonWebToken.encode(account_id: account.id)
      expires_at = JsonWebToken.decode(token)[:exp]

      render json: { token:, expires_at:, account_id: account.id }, status: :ok
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end

  def validate_jwt_token
    authorization_header = request.headers["Authorization"]
    token = authorization_header.split(" ").last if authorization_header
    decoded_token = JsonWebToken.decode(token)
    account_id = decoded_token[:account_id]
    Account.find(account_id)
  rescue
    render json: { message: "unauthorized. account not found" }, status: :unauthorized
  else
    render json: { token:,
                    account_id:,
                    expiration_in: Time.at(decoded_token["exp"]).strftime("%Y-%m-%d") }, status: :ok
  end
end
