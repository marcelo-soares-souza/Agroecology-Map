# frozen_string_literal: true

class DashboardController < ApplicationController
  skip_before_action :authenticate, except: %i[index, show], if: -> { request.format.json? }
  def index
    @locations = Location.all
    @locations_count = Location.count
    @practices_count = Practice.count
    @accounts_count = Account.count

    @practices_recycling_count = Practice.by_agroecology_principles_addressed("Recycling").count
    @practices_input_reduction_count = Practice.by_agroecology_principles_addressed("Input Reduction").count
    @practices_soil_health_count = Practice.by_agroecology_principles_addressed("Soil Health").count
    @practices_animal_health_count = Practice.by_agroecology_principles_addressed("Animal Health").count
    @practices_biodiversity_count = Practice.by_agroecology_principles_addressed("Biodiversity").count
    @practices_synergy_count = Practice.by_agroecology_principles_addressed("Synergy").count
    @practices_economic_diversification_count = Practice.by_agroecology_principles_addressed("Economic diversification").count
    @practices_co_creation_of_knowledge_count = Practice.by_agroecology_principles_addressed("Co-creation of knowledge").count
    @practices_social_values_and_diets_count = Practice.by_agroecology_principles_addressed("Social values and diets").count
    @practices_fairness_count = Practice.by_agroecology_principles_addressed("Fairness").count
    @practices_connectivity_count = Practice.by_agroecology_principles_addressed("Connectivity").count
    @practices_land_and_natural_resource_governance_count = Practice.by_agroecology_principles_addressed("Land and natural resource governance").count
    @practices_participation_count = Practice.by_agroecology_principles_addressed("Participatio").count

    @practices_soil_count = Practice.by_food_system_components_addressed("soil").count
    @practices_water_count = Practice.by_food_system_components_addressed("water").count
    @practices_crops_count = Practice.by_food_system_components_addressed("crops").count
    @practices_livestock_count = Practice.by_food_system_components_addressed("livestock").count
    @practices_fish_count = Practice.by_food_system_components_addressed("fish").count
    @practices_trees_count = Practice.by_food_system_components_addressed("trees").count
    @practices_pests_count = Practice.by_food_system_components_addressed("pests").count
    @practices_energy_count = Practice.by_food_system_components_addressed("energy").count
    @practices_household_count = Practice.by_food_system_components_addressed("household").count
    @practices_workers_count = Practice.by_food_system_components_addressed("workers").count
    @practices_community_count = Practice.by_food_system_components_addressed("community").count
    @practices_value_chain_count = Practice.by_food_system_components_addressed("value chain").count
    @practices_policy_count = Practice.by_food_system_components_addressed("policy").count
    @practices_whole_food_system_count = Practice.by_food_system_components_addressed("whole food").count
    @practices_other_count = Practice.by_food_system_components_addressed("other").count
    @practices_i_am_not_sure_count = Practice.by_food_system_components_addressed("i am not sure").count

    @practices_on_count = Practice.by_where_it_is_realized("On-farm").count
    @practices_off_count = Practice.by_where_it_is_realized("Off-farm").count
    @practices_other_count = Practice.by_where_it_is_realized("Other").count

    @practices_formal_knowledge_count = Practice.by_knowledge_source("Formal knowledge").count
    @practices_indigenous_knowledge_count = Practice.by_knowledge_source("Indigenous knowledge").count
    @practices_local_knowledge_count = Practice.by_knowledge_source("Local knowledge").count
    @practices_personal_experimentation_count = Practice.by_knowledge_source("Personal experimentation").count
    @practices_knowledge_other_count = Practice.by_knowledge_source("Other").count
    @practices_knowledge_i_am_not_sure_count = Practice.by_knowledge_source("I am not sure").count

    @practices_farm_system_crops_count = Practice.by_farm_and_farming_system_complement("Crops").count
    @practices_farm_system_animals_count = Practice.by_farm_and_farming_system_complement("Animals").count
    @practices_farm_system_trees_count = Practice.by_farm_and_farming_system_complement("Trees").count
    @practices_farm_system_fish_count = Practice.by_farm_and_farming_system_complement("Fish").count
    @practices_farm_system_other_count = Practice.by_farm_and_farming_system_complement("Other").count

    @location_by_country = Location.group(:country).count
  end
end
