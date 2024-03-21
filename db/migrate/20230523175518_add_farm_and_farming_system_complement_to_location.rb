# frozen_string_literal: true

class AddFarmAndFarmingSystemComplementToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :farm_and_farming_system_complement, :string
  end
end
