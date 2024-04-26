# frozen_string_literal: true

class AddHideMyLocationToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :hide_my_location, :boolean
  end
end
