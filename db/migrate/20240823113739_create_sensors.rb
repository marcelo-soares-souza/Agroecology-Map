# frozen_string_literal: true

class CreateSensors < ActiveRecord::Migration[7.2]
  def change
    create_table :sensors do |t|
      t.float :temperature
      t.float :humidity
      t.float :moisture
      t.float :sun
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
