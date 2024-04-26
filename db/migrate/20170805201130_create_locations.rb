# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.float :latitude
      t.float :longitude
      t.references :account, foreign_key: true

      t.timestamps
    end
    add_index :locations, :slug, unique: true
  end
end
