# frozen_string_literal: true

class WhatYouDosController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :authenticate_account!, only: %i[new edit update destroy], if: -> { !request.format.json? }

  before_action -> { check_owner WhatYouDo.find(params[:id]).practice.account_id }, only: %i[edit update destroy]
  before_action :set_what_you_do, only: %i[ show edit update destroy ]
  before_action :authenticate_account!, only: %i[new edit update destroy]
  before_action :load_options_what_you_do
  before_action :load_yes_no_i_am_not_sure_options

  # GET /what_you_dos or /what_you_dos.json
  def index
    @what_you_dos = WhatYouDo.all
  end

  # GET /what_you_dos/1 or /what_you_dos/1.json
  def show
  end

  # GET /what_you_dos/new
  def new
    begin
      @practice = Practice.friendly.find(params[:practice_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to locations_path, notice: "This Practice doesn't exist."
    end

    # ToDo: Recover Data Between Navigation
    # @what_you_do_prev = WhatYouDo.where(practice_id: @practice.id).first
    @what_you_do = WhatYouDo.new
    # @what_you_do.summary_description_of_agroecological_practice = @what_you_do_prev.summary_description_of_agroecological_practice
  end

  # GET /what_you_dos/1/edit
  def edit
  end

  # POST /what_you_dos or /what_you_dos.json
  def create
    @what_you_do = WhatYouDo.where(practice_id: params[:what_you_do][:practice_id]).first

    respond_to do |format|
      if @what_you_do
        @what_you_do.update(what_you_do_params)
        format.html { redirect_to new_practice_characterise_path(@what_you_do.practice), notice: "What you do was successfully Updated." }
        format.json { render json: { message: "created" }, status: :created }
      else
        @what_you_do = WhatYouDo.new(what_you_do_params)
        if @what_you_do.save
          format.html { redirect_to new_practice_characterise_path(@what_you_do.practice), notice: "What you do was successfully created." }
          format.json { render :show, status: :created, location: @what_you_do }
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @what_you_do.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /what_you_dos/1 or /what_you_dos/1.json
  def update
    respond_to do |format|
      if @what_you_do.update(what_you_do_params)
        format.html { redirect_to what_you_do_url(@what_you_do), notice: "What you do was successfully updated." }
        format.json { render :show, status: :ok, location: @what_you_do }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @what_you_do.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /what_you_dos/1 or /what_you_dos/1.json
  def destroy
    @practice = @what_you_do.practice
    @what_you_do.destroy

    respond_to do |format|
      format.html { redirect_to practice_path(@practice), notice: "What you do was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_what_you_do
      @what_you_do = WhatYouDo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def what_you_do_params
      params.require(:what_you_do).permit(:practice_id, :where_it_is_realized, :land_size, :substitution_of_less_ecological_alternative, :summary_description_of_agroecological_practice,
                                          :type_of_agroecological_practice, :practical_implementation_of_the_practice,
                                          :why_you_use_and_what_you_expect_from_this_practice, :substitution_of_less_ecological_alternative_details, :unit_of_measure)
    end
end
