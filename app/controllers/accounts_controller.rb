# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }

  before_action :set_account, only: %i[show edit update destroy]
  before_action :authenticate_account!, except: %i[show index]
  before_action -> { check_owner Account.friendly.find(params[:id]).id }, only: %i[edit update destroy]
  before_action :load_total

  def index
    @accounts = if params[:filter]
      filter
    else
      all
    end
  end

  def all
    @accounts = Account.order("updated_at DESC").includes(:medias, :practices, :locations).with_attached_photo.page(params[:page])
  end

  def filter
    @accounts = Account.unscoped
    @accounts = @accounts.by_name(params[:name]) unless params[:name].blank?
    @accounts = @accounts.with_attached_photo
    @total = @accounts.count
    @accounts = @accounts.order("accounts.updated_at DESC").page(params[:page])
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: "Account has been Updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account has been removed." }
      format.json { head :no_content }
    end
  end

  private
    def set_account
      @account = Account.friendly.find(params[:id])
    end

    def account_params
      if current_account.admin?
        params.require(:account).permit(:id, :email, :name, :about, :website, :slug, :photo, :i_agree_with_terms_and_conditions, :admin)
      else
        params.require(:account).permit(:id, :email, :name, :about, :website, :slug, :photo, :i_agree_with_terms_and_conditions)
      end
    end

    def load_total
      @total = Account.count
    end
end
