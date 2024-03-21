# frozen_string_literal: true

class DocumentsController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :set_document, only: %i[show edit update destroy]
  before_action :authenticate_account!, only: %i[new edit update destroy]
  before_action -> { check_owner Document.find(params[:id]).account_id }, only: %i[edit update destroy]
  before_action :load_dados
  before_action :selected_id
  before_action :load_documents

  # GET /documents
  # GET /documents.json
  def index
  end

  # GET /gallery
  # GET /gallery.json
  def gallery
  end

  # GET /documents/1
  # GET /documents/1.json
  def show; end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit; end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @document.account_id = current_account.id unless current_account.admin?

    if params[:practice_id]
      @document.practice_id = @practice.id
      @document.location_id = @practice.location.id
    elsif params[:location_id]
      @document.location_id = @location.id
    end

    respond_to do |format|
      if @document.save
        if params[:practice_id]
          format.html { redirect_to new_practice_document_path(@practice), notice: "Document has been sent" }
        elsif params[:location_id]
          format.html do
            redirect_to new_location_document_path(@location),  notice: "Document has been sent"
          end
        end
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        if params[:practice_id]
          format.html { redirect_to practice_gallery_path(@practice, @document), notice: "Document has been updated." }
        elsif params[:location_id]
          format.html do
            redirect_to location_gallery_path(@location),  notice: "Document has been updated."
          end
        end
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy

    respond_to do |format|
      if params[:practice_id]
        format.html { redirect_to practice_documents_path(@practice), notice: "Document has been removed." }
      elsif params[:location_id]
        format.html do
          redirect_to location_documents_path(@location), notice: "Document has been removed."
        end
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:description, :practice_id, :location_id, :file, :account_id)
    end

    def load_dados
      if params[:practice_id]
        @practice = Practice.friendly.find(params[:practice_id])
      elsif params[:location_id]
        @location = Location.friendly.find(params[:location_id])
      end
    end

    def selected_id
      if current_account && current_account.admin?
        @selected_id = current_account.id
        if @practice
          @selected_id = @practice.account.id
        elsif @location
          @selected_id = @location.account.id
        end
      end
    end

    def load_documents
      if params[:practice_id]
        @documents = Document.where(practice_id: @practice.id).order("updated_at DESC").page(params[:page])
      elsif params[:location_id]
        @documents = Document.where(location_id: @location.id).order("updated_at DESC").page(params[:page])
      end
    end
end
