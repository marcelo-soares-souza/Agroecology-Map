# frozen_string_literal: true

class CharacterisesController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :authenticate_account!, only: %i[new edit update destroy], if: -> { !request.format.json? }

  before_action -> { check_owner Characterise.find(params[:id]).practice.account_id }, only: %i[edit update destroy]
  before_action :set_characterise, only: %i[ show edit update destroy ]

  # GET /characterises or /characterises.json
  def index
    @characterises = Characterise.all
  end

  # GET /characterises/1 or /characterises/1.json
  def show
  end

  # GET /characterises/new
  def new
    begin
      @practice = Practice.friendly.find(params[:practice_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to locations_path, notice: "This Practice doesn't exist."
    end

    @characterise = Characterise.new
  end

  # GET /characterises/1/edit
  def edit
  end

  # POST /characterises or /characterises.json
  def create
    @characterise = Characterise.where(practice_id: params[:characterise][:practice_id]).first
    respond_to do |format|
      if @characterise
        @characterise.update(characterise_params)
        format.html { redirect_to new_practice_evaluate_path(@characterise.practice), notice: "Characterise was successfully Updated." }
        format.json { render json: { message: "created" }, status: :created }
      else
        @characterise = Characterise.new(characterise_params)
        if @characterise.save
          format.html { redirect_to new_practice_evaluate_path(@characterise.practice), notice: "Characterise was successfully created." }
          format.json { render :show, status: :created, location: @characterise }
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @characterise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characterises/1 or /characterises/1.json
  def update
    respond_to do |format|
      if @characterise.update(characterise_params)
        format.html { redirect_to characterise_url(@characterise), notice: "Characterise was successfully updated." }
        format.json { render :show, status: :ok, location: @characterise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @characterise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characterises/1 or /characterises/1.json
  def destroy
    @characterise.destroy

    respond_to do |format|
      format.html { redirect_to characterises_url, notice: "Characterise was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_characterise
      @characterise = Characterise.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def characterise_params
      if request.format.json?
        params.require(:characterise).permit(:practice_id, :food_system_components_addressed, :agroecology_principles_addressed)
      else
        params.require(:characterise).permit(:practice_id, food_system_components_addressed: [], agroecology_principles_addressed: [])
      end
    end
end
