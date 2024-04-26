# frozen_string_literal: true

class AcknowledgesController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :authenticate_account!, only: %i[new edit update destroy], if: -> { !request.format.json? }

  before_action :authenticate_account!, only: %i[new edit update destroy]
  before_action -> { check_owner Acknowledge.find(params[:id]).practice.account_id }, only: %i[edit update destroy]

  before_action :set_acknowledge, only: %i[ show edit update destroy ]
  before_action :load_practice, only: %i[ edit ]
  before_action :load_options_acknowledges

  # GET /acknowledges or /acknowledges.json
  def index
    @acknowledges = Acknowledge.all
  end

  # GET /acknowledges/1 or /acknowledges/1.json
  def show
  end

  # GET /acknowledges/new
  def new
    begin
      @practice = Practice.friendly.find(params[:practice_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to locations_path, notice: "This Practice doesn't exist."
    end

    @acknowledge = Acknowledge.new
  end

  # GET /acknowledges/1/edit
  def edit
  end

  # POST /acknowledges or /acknowledges.json
  def create
    @acknowledge = Acknowledge.where(practice_id: params[:acknowledge][:practice_id]).first
    respond_to do |format|
      if @acknowledge
        @acknowledge.update(acknowledge_params)
        format.html { redirect_to location_practice_path(@acknowledge.practice.location, @acknowledge.practice), notice: "Acknowledges was successfully Updated." }
        format.json { render json: { message: "created" }, status: :created }
      else
        @acknowledge = Acknowledge.new(acknowledge_params)
        if @acknowledge.save
          format.html { redirect_to location_practice_path(@acknowledge.practice.location, @acknowledge.practice), notice: "Acknowledges was successfully created." }
          format.json { render :show, status: :created, location: @acknowledge }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @acknowledge.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /acknowledges/1 or /acknowledges/1.json
  def update
    respond_to do |format|
      if @acknowledge.update(acknowledge_params)
        format.html { redirect_to acknowledge_url(@acknowledge), notice: "Acknowledge was successfully updated." }
        format.json { render :show, status: :ok, location: @acknowledge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @acknowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acknowledges/1 or /acknowledges/1.json
  def destroy
    @acknowledge.destroy

    respond_to do |format|
      format.html { redirect_to acknowledges_url, notice: "Acknowledge was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acknowledge
      @acknowledge = Acknowledge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def acknowledge_params
      if request.format.json?
        params.require(:acknowledge).permit(:practice_id, :knowledge_timing, :knowledge_products, :knowledge_source_details, :knowledge_timing_details, :uptake_motivation, :knowledge_source)
      else
        params.require(:acknowledge).permit(:practice_id, :knowledge_timing, :knowledge_products, :knowledge_source_details, :knowledge_timing_details, :uptake_motivation, knowledge_source: [])
      end
    end

    def load_practice
      @practice = Practice.friendly.find(params[:practice_id])
    end
end
