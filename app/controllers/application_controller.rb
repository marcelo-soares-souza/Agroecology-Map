# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }

  rescue_from JWT::VerificationError, with: :invalid_token
  rescue_from JWT::DecodeError, with: :decode_error

  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_schema_org
  before_action :set_og
  rescue_from ActionController::InvalidAuthenticityToken, with: :rescue_invalid_authenticity_token

  protected
    def set_og
      @og_title = "Agroecology Map"
      @og_description = "Agroecology Map Knowledge and Practices is a Free (Open) Platform for Mapping Initiatives in Agroecology, Permaculture and Agroforestry Systems"
      @og_image = "https://agroecologymap.org/logo.png"
      @og_url = "https://agroecologymap.org/"
    end

    def set_schema_org
      @schema_org = SchemaDotOrg::Organization.new(
        name:             "Agroecology Map",
        founder:           SchemaDotOrg::Person.new(name: "Marcelo Soares Souza"),
        founding_date:     Date.new(2023, 6, 17),
        founding_location: SchemaDotOrg::Place.new(address: "Brasília, DF, Brazil"),
        email:            "marcelo@agroecologymap.org",
        telephone:        "+5512345678900",
        url:              "https://agroecologymap.org",
        logo:             "https://agroecologymap.org/logo.png"
      )
    end

    def set_locale
      default_locale = "en"
      I18n.default_locale = default_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale] = I18n.locale

      ISO3166.configure do |config|
        config.locales = [:en, :pt_BR, :es, :fr]
      end
    end

    def default_url_options(options = {})
      { locale: I18n.locale }
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :i_agree_with_terms_and_conditions, :humanizer_answer, :humanizer_question_id])
    end

    def check_owner(account_id)
      if signed_in? && (!current_account.admin? && current_account.id != (account_id))
        redirect_to root_url, alert: t(:permission_denied)
      end
    end

    def check_owner_or_collaborator(account_id, collaborators)
      if signed_in? && (!current_account.admin? && current_account.id != account_id && !collaborators.collect(&:account_id).include?(current_account.id))
        redirect_to root_url, alert: t(:permission_denied)
      end
    end

    def check_if_admin
      redirect_to root_url, alert: t(:permission_denied) if signed_in? && !current_account.admin?
    end

    def load_locations
      @locations = if current_account.admin?
        Location.all
      else
        Location.where(account_id: current_account.id)
      end
    end

    def rescue_invalid_authenticity_token
      redirect_to "/422"
    end

    def load_yes_no_i_am_not_sure_options
      @yes_no_i_am_not_sure_options = {
        "1 - " + t(:yes_query) => "Yes",
        "2 - " + t(:no_query) => "No",
        "3 - " + t(:i_am_not_sure) => "I am not sure",
      }

      @yes_no_i_am_not_sure_not_applicable_options = {
        "1 - " + t(:yes_query) => "Yes",
        "2 - " + t(:no_query) => "No",
        "3 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }
    end

    def load_effective_options
      @effective_options = {
        "5 - " + t(:very_effective) => "Very effective",
        "4 - " + t(:rather_effective) => "Rather effective",
        "3 - " + t(:neither_effective_nor_uneffective) => "Neither effective nor uneffective",
        "2 - " + t(:rather_uneffective) => "Rather uneffective",
        "1 - " + t(:very_uneffective) => "Very uneffective",
        "0 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }
    end

    def load_system_options
      @system_functions_options = {
        # "Filter by Farm Functions" => "Filter",
        # "All" => "All",
        "1 - " + t(:mainly_home_consumption) => "Mainly Home Consumption",
        "2 - " + t(:mixed_home_consumption_and_commercial) => "Mixed Home Consumption and Commercial",
        "3 - " + t(:mainly_commercial) => "Mainly commercial",
        "4 - " + t(:other) => "Other",
        "5 - " + t(:i_am_not_sure) => "I Am not Sure"
      }

      @system_components_options = {
        # "Filter by Farm Components" => "Filter",
        # "All" => "All",
        "1 - " + t(:crops) => "Crops",
        "2 - " + t(:animals) => "Animals",
        "3 - " + t(:trees) => "Trees",
        "4 - " + t(:fish) => "Fish",
        "5 - " + t(:other) => "Other",
      }

      @continent_options = {
        # "Filter by Continent" => "Filter",
        # "All" => "All",
        "Africa" => "Africa",
        "Asia" => "Asia",
        "Europe" => "Europe",
        "North America" => "North America",
        "South America" => "South America",
        "Australia/Oceania" => "Australia",
        "Antarctica" => "Antarctica"
      }
    end

    def load_principles
      @food_system_components_addressed_options = {
        # "Filter by System Component" => "Filter",
        # "All" => "All",
        "1 - " + t(:soil) => "Soil",
        "2 - " + t(:water) => "Water",
        "3 - " + t(:crops) => "Crops",
        "4 - " + t(:livestock) => "Livestock",
        "5 - " + t(:fish) => "Fish",
        "6 - " + t(:trees) => "Trees",
        "7 - " + t(:pests) => "Pests",
        "8 - " + t(:energy) => "Energy",
        "9 - " + t(:household) => "Household",
        "10 - " + t(:workers) => "Workers",
        "11 - " + t(:community) => "Community",
        "12 - " + t(:value_chain) => "Value chain",
        "13 - " + t(:policy) => "Policy",
        "14 - " + t(:whole_food_system) => "Whole Food System",
        "15 - " + t(:other) => "Other",
        "16 - " + t(:i_am_not_sure) => "I am not sure"
      }

      @agroecology_principles_addressed_options = {
        # "Filter by Agroecology Principle" => "Filter",
        # "All" => "All",
        "1 - " + t(:recycling) => "Recycling",
        "2 - " + t(:input_reduction) => "Input reduction",
        "3 - " + t(:soil_health) => "Soil health",
        "4 - " + t(:animal_health) => "Animal health",
        "5 - " + t(:biodiversity) => "Biodiversity",
        "6 - " + t(:synergy) => "Synergy",
        "7 - " + t(:economic_diversification) => "Economic diversification",
        "8 - " + t(:co_creation_of_knowledge) => "Co-creation of knowledge",
        "9 - " + t(:social_values_and_diets) => "Social values and diets",
        "10 - " + t(:fairness) => "Fairness",
        "11 - " + t(:connectivity) => "Connectivity",
        "12 - " + t(:land_and_natural_resource_governance) => "Land and natural resource governance",
        "13 - " + t(:participation) => "Participation"
      }
    end


    def load_options_what_you_do
      @where_it_is_realized_options = {
        "1 - " + t(:on_farm) => "On-farm",
        "2 - " + t(:off_farm) => "Off-farm",
        "3 - " + t(:other) => "Other"
      }

      @unit_of_measure_options = {
        "m2" => "m2",
        "Acre" => "Acre",
        "Hectare" => "Hectare",
        "Square foot" => "Square foot",
        t(:not_applicable) => "Not applicable"
      }
    end

    def load_options_acknowledges
      @knowledge_source_options = {
        t(:formal_knowledge) => "Formal knowledge",
        t(:indigenous_knowledge) => "Indigenous knowledge",
        t(:local_knowledge) => "Local knowledge",
        t(:personal_experimentation) => "Personal experimentation",
        t(:other) => "Other",
        t(:i_am_not_sure) => "I am not sure"
      }

      @knowledge_timing_options = {
        "3 - " + t(:a_long_time_ago) => "A long time ago",
        "2 - " + t(:some_time_ago) => "Some time ago",
        "1 - " + t(:recently) => "Recently",
        "0 - " + t(:i_am_not_sure) => "I am not sure"
      }
    end

    def load_evaluates_options
      @knowledge_and_skills_required_for_practice_options = {
        "5 - " + t(:high_specialised_knowledge_required) => "High specialised knowledge required",
        "4 - " + t(:rather_high_specialised_knowledge_required) => "Rather high specialised knowledge required",
        "3 - " + t(:specialised_knowledge_required_neither_high_nor_low) => "Specialised knowledge required neither high nor low",
        "2 - " + t(:rather_low_specialised_knowledge_required) => "Rather low specialised knowledge required",
        "1 - " + t(:no_specialised_knowledge_required) => "No specialised knowledge required",
        "0 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }

      @cost_associated_with_practice_options = {
        "5 - " + t(:high_costs) => "High costs",
        "4 - " + t(:rather_high_costs) => "Rather high costs",
        "3 - " + t(:neither_high_nor_low_costs) => "Rather high costs",
        "2 - " + t(:rather_low_costs) => "Rather low costs",
        "1 - " + t(:low_costs) => "Low costs",
        "0 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }

      @labour_required_for_practice_options = {
        "5 - " + t(:high_labour_required) => "High labour required",
        "4 - " + t(:rather_high_labour_required) => "Rather high labour required",
        "3 - " + t(:neither_high_nor_low_labout_required) => "Neither high nor low labout required",
        "2 - " + t(:rather_low_labour_required) => "Rather low labour required",
        "1 - " + t(:low_labour_required) => "Low labour required",
        "0 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }

      @time_requirements_options = {
        "5 - " + t(:works_instantly) => "Works instantly",
        "4 - " + t(:works_rather_rapidly) => "Works rather rapidly",
        "3 - " + t(:works_neither_rapidly_nor_slowly) => "Works neither rapidly nor slowly",
        "2 - " + t(:takes_rather_long_to_work) => "Takes rather long to work",
        "1 - " + t(:takes_very_long_to_work) => "Takes very long to work",
        "0 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }

      @does_it_work_in_degraded_environments_options = {
        "5 - " + t(:works_well_in_depleted_environment) => "Works well in depleted environment",
        "4 - " + t(:works_rather_well_in_depleted_environment) => "Works rather well in depleted environment",
        "3 - " + t(:neither_works_well_nor_poorly_in_depleted_environment) => "Neither works well nor poorly in depleted environment",
        "2 - " + t(:does_rather_not_work_in_depleted_environment) => "Does rather not work in depleted environment",
        "1 - " + t(:does_not_work_at_all_in_depleted_environment) => "Does not work at all in depleted environment",
        "0 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }
    end

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:account, request.fullpath)
    end

    def authenticate
      authorization_header = request.headers["Authorization"]
      token = authorization_header.split(" ").last if authorization_header
      decoded_token = JsonWebToken.decode(token)

      Account.find(decoded_token[:account_id])
    end

    def invalid_token
      render json: { invalid_token: "invalid token" }, status: :unauthorized
    end

    def decode_error
      render json: { decode_error: "decode error" }, status: :unauthorized
    end
end
