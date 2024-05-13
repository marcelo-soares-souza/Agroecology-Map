# frozen_string_literal: true

class ConnectController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  before_action :load_system_options
  before_action :load_principles
  before_action :load_options_what_you_do
  before_action :load_options_acknowledges
  before_action :load_yes_no_i_am_not_sure_options
  before_action :load_effective_options
  before_action :load_evaluates_options

  def index
    @practices = if params[:filter]
      filter
    else
      all
    end
  end

  def all
    @practices = if params[:location_id]
      Practice.where(location_id: @location.id).sort_by(&:updated_at).reverse
    elsif params[:account_id]
      Practice.where(account_id: @account.id).sort_by(&:updated_at).reverse
    else
      Practice.includes(:account, :location).with_attached_photo.order("updated_at DESC").page(params[:page])
    end
  end
  def filter
    @practices = Practice.unscoped
    @practices = @practices.by_name(params[:name]) unless params[:name].blank?
    @practices = @practices.by_food_system_components_addressed(params[:components]) unless params[:components].blank?
    @practices = @practices.by_agroecology_principles_addressed(params[:principles]) unless params[:principles].blank?
    @practices = @practices.by_where_it_is_realized(params[:where_it_is_realized]) unless params[:where_it_is_realized].blank?
    @practices = @practices.by_knowledge_source(params[:knowledge_source]) unless params[:knowledge_source].blank?
    @practices = @practices.by_farm_and_farming_system(params[:system_functions]) unless params[:system_functions].blank?
    @practices = @practices.by_farm_and_farming_system_complement(params[:system_components]) unless params[:system_components].blank?
    @practices = @practices.by_country(params[:country]) unless params[:country].blank?
    @practices = @practices.by_continent(params[:continent]) unless params[:continent].blank?
    @practices = @practices.by_substitution_of_less_ecological_alternative(params[:substitution_of_less_ecological_alternative]) unless params[:substitution_of_less_ecological_alternative].blank?
    @practices = @practices.by_does_it_help_restore_land(params[:does_it_help_restore_land]) unless params[:does_it_help_restore_land].blank?
    @practices = @practices.by_does_it_work_in_degraded_environments(params[:does_it_work_in_degraded_environments]) unless params[:does_it_work_in_degraded_environments].blank?
    @practices = @practices.by_knowledge_and_skills_required_for_practice(params[:knowledge_and_skills_required_for_practice]) unless params[:knowledge_and_skills_required_for_practice].blank?
    @practices = @practices.with_attached_photo
    @practices = @practices.order("practices.updated_at DESC").page(params[:page])
  end
end
