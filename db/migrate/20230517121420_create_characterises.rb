# frozen_string_literal: true

class CreateCharacterises < ActiveRecord::Migration[7.0]
  def change
    create_table :characterises do |t|
      t.references :practice, null: false, foreign_key: true
      t.text :agroecology_principles_addressed
      t.text :food_system_components_addressed

      t.timestamps
    end
  end
end
