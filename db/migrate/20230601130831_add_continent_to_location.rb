# frozen_string_literal: true

class AddContinentToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :continent, :string
  end
end
