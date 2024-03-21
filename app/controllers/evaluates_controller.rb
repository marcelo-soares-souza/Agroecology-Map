# frozen_string_literal: true

class EvaluatesController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :authenticate_account!, only: %i[new edit update destroy], if: -> { !request.format.json? }

  before_action -> { check_owner Evaluate.find(params[:id]).practice.account_id }, only: %i[edit update destroy]

  before_action :set_evaluate, only: %i[ show edit update destroy ]
  before_action :load_effective_options
  before_action :load_yes_no_i_am_not_sure_options
  before_action :load_evaluates_options

  # GET /evaluates or /evaluates.json
  def index
    @evaluates = Evaluate.all
  end

  # GET /evaluates/1 or /evaluates/1.json
  def show
  end

  # GET /evaluates/new
  def new
    begin
      @practice = Practice.friendly.find(params[:practice_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to locations_path, notice: "This Practice doesn't exist."
    end

    @evaluate = Evaluate.new
  end

  # GET /evaluates/1/edit
  def edit
  end

  # POST /evaluates or /evaluates.json
  def create
    @evaluate = Evaluate.where(practice_id: params[:evaluate][:practice_id]).first
    respond_to do |format|
      if @evaluate
        @evaluate.update(evaluate_params)
        format.html { redirect_to new_practice_acknowledge_path(@evaluate.practice), notice: "Evaluate was successfully Updated." }
        format.json { render json: { message: "created" }, status: :created }
      else
        @evaluate = Evaluate.new(evaluate_params)
        if @evaluate.save
          format.html { redirect_to new_practice_acknowledge_path(@evaluate.practice), notice: "Evaluate was successfully created." }
          format.json { render :show, status: :created, location: @evaluate }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @evaluate.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /evaluates/1 or /evaluates/1.json
  def update
    respond_to do |format|
      if @evaluate.update(evaluate_params)
        format.html { redirect_to evaluate_url(@evaluate), notice: "Evaluate was successfully updated." }
        format.json { render :show, status: :ok, location: @evaluate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @evaluate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluates/1 or /evaluates/1.json
  def destroy
    @evaluate.destroy

    respond_to do |format|
      format.html { redirect_to evaluates_url, notice: "Evaluate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluate
      @evaluate = Evaluate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def evaluate_params
      params.require(:evaluate).permit(:practice_id, :general_performance_of_practice, :unintended_positive_side_effects_of_practice, :unintended_negative_side_effect_of_practice,
                                       :knowledge_and_skills_required_for_practice, :labour_required_for_practice, :cost_associated_with_practice, :does_it_work_in_degraded_environments,
                                       :does_it_help_restore_land, :climate_change_vulnerability_effects, :time_requirements,
                                       :general_performance_of_practice_details, :unintended_positive_side_effects_of_practice_details, :unintended_negative_side_effect_of_practice_details,
                                       :knowledge_and_skills_required_for_practice_details, :labour_required_for_practice_details, :cost_associated_with_practice_details,
                                       :does_it_work_in_degraded_environments_details, :does_it_help_restore_land_details, :climate_change_vulnerability_effects_details, :time_requirements_details)
    end
end
