# frozen_string_literal: true

class AddVisitsToLocation < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :visits, :integer, default: 0
  end
end
