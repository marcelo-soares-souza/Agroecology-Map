# frozen_string_literal: true

class AddDetailsFieldsToEvaluate < ActiveRecord::Migration[7.0]
  def change
    add_column :evaluates, :general_performance_of_practice_details, :text
    add_column :evaluates, :unintended_positive_side_effects_of_practice_details, :text
    add_column :evaluates, :unintended_negative_side_effect_of_practice_details, :text
    add_column :evaluates, :knowledge_and_skills_required_for_practice_details, :text
    add_column :evaluates, :labour_required_for_practice_details, :text
    add_column :evaluates, :cost_associated_with_practice_details, :text
    add_column :evaluates, :does_it_work_in_degraded_environments_details, :text
    add_column :evaluates, :does_it_help_restore_land_details, :text
    add_column :evaluates, :climate_change_vulnerability_effects_details, :text
    add_column :evaluates, :time_requirements_details, :text
  end
end
