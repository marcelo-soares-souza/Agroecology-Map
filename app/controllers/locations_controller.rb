# frozen_string_literal: true

class LocationsController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }

  before_action :authenticate_account!, only: %i[new edit update destroy like], if: -> { !request.format.json? }

  before_action -> { check_owner Location.friendly.find(params[:id]).account_id }, only: %i[edit update destroy]

  before_action :set_location, only: %i[show edit update destroy]
  before_action :load_account
  before_action :load_all_accounts, except: %i[index show]
  before_action :load_total_medias, only: %i[show]
  before_action :load_options
  before_action :load_system_options
  before_action :load_total

  # GET /locations
  # GET /locations.json
  def index
    @locations = if params[:filter]
      filter
    else
      all
    end
  end

  def all
    if params[:account_id]
      Location.where(account_id: @account.id).includes(:medias, :practices).sort_by(&:updated_at).reverse
    else
      if request.format == :html
        Location.includes(:account, :practices).order("updated_at DESC").with_attached_photo.page(params[:page])
      elsif request.format == :geojson
        respond_to do |format|
          format.geojson { render json: generate_geojson, status: :ok  }
        end
      elsif request.format == :csv
        respond_to do |format|
          format.csv { send_data Location.to_csv, filename: "locations-#{DateTime.now.strftime("%Y-%m-%d")}.csv" }
        end
      else
        if params[:page]
          Location.all.includes(:account, :practices).order("updated_at DESC").with_attached_photo.page(params[:page])
        else
          Location.all.includes(:account, :practices).order("updated_at DESC").with_attached_photo
        end
      end
    end
  end

  def filter
    @locations = Location.unscoped
    @locations = @locations.includes(:practices)
    @locations = @locations.by_name(params[:name]) unless params[:name].blank?
    @locations = @locations.by_farm_and_farming_system(params[:system_functions]) unless params[:system_functions].blank?
    @locations = @locations.by_farm_and_farming_system_complement(params[:system_components]) unless params[:system_components].blank?
    @locations = @locations.by_country(params[:country]) unless params[:country].blank?
    @locations = @locations.by_continent(params[:continent]) unless params[:continent].blank?
    @locations = @locations.with_attached_photo
    @total = @locations.count

    if request.format == :html
      @locations = @locations.order("locations.updated_at DESC").page(params[:page])
    else
      @locations = @locations.order("locations.updated_at DESC")
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    if (not browser.bot?) && (not request.is_crawler?)
      @location.visits += 1
      @location.save!
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)


    if request.format.json?
      if params[:base64Image]
        base64Image = params[:base64Image]
        decoded_data = Base64.decode64(base64Image)
        @location.photo = {
                            io: StringIO.new(decoded_data),
                            content_type: "image/jpeg",
                            filename: "image.jpg"
                          }
      end

      @location.account_id = authenticate.id
    else
      @location.account_id = current_account.id unless current_account.admin?
    end

    respond_to do |format|
      if @location.save
        format.html { redirect_to new_location_practice_path(@location), notice: t(:location_has_been_registered) }
        format.json { render json: { message: "created" }, status: :created }
      else
        format.html { render :new }
        format.json { render json: { error: @location.errors }, status: :unprocessable_entity }
        # format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: t(:location_has_been_updated) }
        format.json { render json: { message: "updated" }, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location has been removed." }
      format.json { head :no_content }
    end
  end

  def coordinates
    @location = Geocoder.search(params[:country].blank? ? "Brazil" : params[:country])
  end

  def countries
    @countries = ISO3166::Country.find_all_countries_by_continent(params[:continent]).map(&:alpha2)
  end

  def like
    @location = Location.friendly.find(params[:id])
    @like = Like.new(account_id: current_account.id, location_id: @location.id)

    if @like.save
      subject = "[Agroecology Map] Someone liked your agroecological location. "
      body = "Liked by: #{@like.account.name} (" + account_url(@like.account) + ")"
      body += "\r\n \r\n"
      body += "Link to your location: " + location_url(@location)
      body += "\r\n \r\n"

      if @location.account.id != current_account.id
        MailJob.perform_async(@location.account.email, subject, body)
      end

      redirect_to location_path(@location), notice: "Your like has been registered! Thanks!!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      if request.format.json?
        params.require(:location).permit(:name, :slug, :country, :description, :farm_and_farming_system_complement,
        :farm_and_farming_system, :farm_and_farming_system_details, :what_is_your_dream, :latitude, :longitude, :account_id,
        :photo, :hide_my_location, :is_it_a_farm, :base64Image, account_ids: [])

      else
        params.require(:location).permit(:name, :slug, :country, :description, :farm_and_farming_system,
                                       :farm_and_farming_system_details, :what_is_your_dream, :latitude, :longitude, :account_id,
                                       :photo, :hide_my_location, :is_it_a_farm,
                                       account_ids: [], farm_and_farming_system_complement: [])
      end
    end

    def load_all_accounts
      @accounts = Account.all
    end

    def load_account
      @account = Account.friendly.find(params[:account_id]) if params[:account_id]
    end

    def load_total_medias
      @total_media = Media.where(location_id: @location.id).count
    end

    def load_options
      @farm_and_farming_system_options = {
        "1 - " + t(:mainly_home_consumption) => "Mainly Home Consumption",
        "2 - " + t(:mixed_home_consumption_and_commercial) => "Mixed Home Consumption and Commercial",
        "3 - " + t(:mainly_commercial) => "Mainly commercial",
        "4 - " + t(:other) => "Other",
        "5 - " + t(:i_am_not_sure) => "I am not sure"
      }
    end

    def load_total
      @total = Location.count
    end

    def generate_geojson
      locations = []

      Location.where(hide_my_location: false).order(:id).each do |location|
        locations << GeojsonModel::Feature.new(
          properties: {
            id: location.id,
            name: location.name,
            country: location.country ? ISO3166::Country[location.country].iso_short_name : "",
            country_code: location.country || "",
            continent: location.continent || "",
            farm_and_farming_system: location.farm_and_farming_system || "",
            farm_and_farming_system_details: location.farm_and_farming_system_details || "",
            farm_and_farming_system_complement: location.farm_and_farming_system_complement || "",
            description: location.description || "",
            latitude:  location.latitude,
            longitude: location.longitude,
            url: location_url(location),
            total_of_practices: location.practices.count,
            responsible_for_information: location.account.name,
            created_at: location.created_at,
            updated_at: location.updated_at
          },
          geometry: GeojsonModel::Geometry.new(type: "Point", coordinates: [location.longitude, location.latitude])
        )
      end

      fc = GeojsonModel::FeatureCollection.new(features: locations)
      JSON.pretty_generate(JSON.parse(fc.to_json))
    end
end
