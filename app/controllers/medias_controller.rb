# frozen_string_literal: true

class MediasController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }

  before_action :authenticate_account!, only: %i[new edit update destroy], if: -> { !request.format.json? }

  before_action :set_media, only: %i[show edit update destroy]
  before_action -> { check_owner Media.find(params[:id]).account_id }, only: %i[edit update destroy]
  before_action :load_dados
  before_action :selected_id
  before_action :load_medias

  # GET /medias
  # GET /medias.json
  def index
  end

  # GET /gallery
  # GET /gallery.json
  def gallery
    if request.path == "/en/gallery" || request.path == "/gallery"
      @medias = Media.all.order("updated_at desc").page(params[:page]).per(32)
    end
  end

  # GET /medias/1
  # GET /medias/1.json
  def show; end

  # GET /medias/new
  def new
    @media = Media.new
  end

  # GET /medias/1/edit
  def edit; end

  # POST /medias
  # POST /medias.json
  def create
    @media = Media.new(media_params)

    if request.format.json?
      if params[:base64Image]
        base64Image = params[:base64Image]
        decoded_data = Base64.decode64(base64Image)
        @media.photo = {
                            io: StringIO.new(decoded_data),
                            content_type: "image/jpeg",
                            filename: "image.jpg"
                          }
      end
      @media.account_id = authenticate.id
    else
      @media.account_id = current_account.id unless current_account.admin?
    end

    if params[:practice_id]
      @media.practice_id = @practice.id
      @media.location_id = @practice.location.id
    elsif params[:location_id]
      @media.location_id = @location.id
    end

    respond_to do |format|
      if @media.save
        if params[:practice_id]
          format.html { redirect_to new_practice_media_path(@practice), notice: "Media has been sent" }
        elsif params[:location_id]
          format.html do
            redirect_to new_location_media_path(@location),  notice: "Media has been sent"
          end
        end
        format.json { render json: { message: "created" }, status: :created }
      else
        format.html { render :new }
        format.json { render json: { error: @media.errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medias/1
  # PATCH/PUT /medias/1.json
  def update
    respond_to do |format|
      if @media.update(media_params)
        if params[:practice_id]
          format.html { redirect_to practice_gallery_path(@practice), notice: "Media has been updated." }
        elsif params[:location_id]
          format.html do
            redirect_to location_gallery_path(@location),  notice: "Media has been updated."
          end
        end
        format.json { render :show, status: :ok, location: @media }
      else
        format.html { render :edit }
        format.json { render json: @media.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medias/1
  # DELETE /medias/1.json
  def destroy
    @media.destroy

    respond_to do |format|
      if params[:practice_id]
        format.html { redirect_to practice_gallery_path(@practice), notice: "Media has been removed." }
      elsif params[:location_id]
        format.html do
          redirect_to location_gallery_path(@location), notice: "Media has been removed."
        end
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media
      @media = Media.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_params
      if request.format.json?
        params.require(:media).permit(:description, :practice_id, :location_id, :photo, :account_id, :base64Image)
      else
        params.require(:media).permit(:description, :practice_id, :location_id, :photo, :account_id)
      end
    end

    def load_dados
      if params[:practice_id]
        @practice = Practice.friendly.find(params[:practice_id])
      elsif params[:location_id]
        @location = Location.friendly.find(params[:location_id])
      elsif params[:account_id]
        @account = Account.friendly.find(params[:account_id])
      end
    end

    def selected_id
      if !request.format.json?
        if current_account && current_account.admin?
          @selected_id = current_account.id
          if @practice
            @selected_id = @practice.account.id
          elsif @location
            @selected_id = @location.account.id
          end
        end
      end
    end

    def load_medias
      @full_gallery = false
      if params[:practice_id]
        @medias = Media.where(practice_id: @practice.id).order("updated_at DESC").page(params[:page])
      elsif params[:location_id]
        @medias = Media.where(location_id: @location.id).order("updated_at DESC").page(params[:page])
      elsif params[:account_id]
        @medias = Media.where(account_id: @account.id).order("updated_at DESC").page(params[:page])
      else
        @full_gallery = true
        @total_media = Media.all.count
        @medias = Media.all.order("updated_at DESC").page(params[:page])
      end
    end
end
