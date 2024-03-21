# frozen_string_literal: true

class AddFarmAndFarmingSystemToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :farm_and_farming_system, :string
  end
end
