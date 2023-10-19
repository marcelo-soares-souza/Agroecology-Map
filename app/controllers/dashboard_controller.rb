# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :load_tema_experiencia_agroecologicas
  before_action :load_tipos

  def index
    @location_by_country = Local.group(:country).count
    @location_by_type = Local.group(:tipo).order("count_all desc").count
    @experience_by_theme = ExperienciaAgroecologica.group(:tema_experiencia_agroecologica).order("count_all desc").count
  end

  def load_tema_experiencia_agroecologicas
    @tema_experiencia_agroecologicas = {
      t(:urban_agriculture) => 1,
      t(:food) => 2,
      t(:health_and_medicinal_plants) => 3,
      t(:rural_development) => 4,
      t(:local_development) => 5,
      t(:education) => 6,
      t(:agricultural_research_and_rural_extension) => 7,
      t(:management_of_water_resources) => 8,
      t(:certification) => 9,
      t(:marketing) => 10,
      t(:processing_and_processing_of_production) => 11,
      t(:seeds) => 12,
      t(:agroforestry_systems) => 13,
      t(:management_of_native_vegetation_and_agro_extractivism) => 14,
      t(:animal_husbandry_systems) => 15,
      t(:agricultural_production_system) => 16,
      t(:alternative_agriculture_currents) => 17,
      t(:management_of_pests__diseases_and_weeds) => 18,
      t(:soil_management) => 19,
      t(:access_to_land_agrarian_reform_and_agroecology) => 20,
      t(:relationship_with_the_markets) => 21,
      t(:others) => 22,
      t(:women_and_agroecology) => 23,
      t(:fruit_growing) => 24,
      t(:extractivism) => 25,
      t(:craftsmanship) => 26,
      t(:periurban_agriculture) => 27,
      t(:sovereignty_and_food_security) => 28,
      t(:biodiversity) => 29,
      t(:financing) => 30,
      t(:construction_of_agroecological_knowledge) => 31,
      t(:public_policies_with_an_agroecological_approach) => 32,
      t(:reforestation) => 33,
      t(:compost) => 34,
      t(:eco_tourism) => 35,
      t(:rural_tourism) => 36,
      t(:indigenous_agriculture) => 37
    }
  end

  def load_tipos
    @tipos = {
      t(:settlement) => "Assentamento",
      t(:collective_property) => "Propriedade Coletiva",
      t(:public_property) => "Propriedade Pública (Governo)",
      t(:private_property) => "Propriedade Privada",
      t(:familiar) => "Familiar",
      t(:other) => "Outro"
    }
  end
end
