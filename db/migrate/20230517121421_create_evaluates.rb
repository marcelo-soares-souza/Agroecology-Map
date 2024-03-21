# frozen_string_literal: true

class CreateEvaluates < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluates do |t|
      t.references :practice, null: false, foreign_key: true
      t.text :general_performance_of_practice
      t.text :unintended_positive_side_effects_of_practice
      t.text :unintended_negative_side_effect_of_practice
      t.text :knowledge_and_skills_required_for_practice
      t.text :labour_required_for_practice
      t.text :cost_associated_with_practice
      t.text :does_it_work_in_degraded_environments
      t.text :does_it_help_restore_land
      t.text :climate_change_vulnerability_effects
      t.text :time_requirements

      t.timestamps
    end
  end
end
