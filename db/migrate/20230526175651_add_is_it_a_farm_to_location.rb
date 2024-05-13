# frozen_string_literal: true

class AddIsItAFarmToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :is_it_a_farm, :boolean
  end
end
