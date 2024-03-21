# frozen_string_literal: true

class AddUptakeMotivationToAcknowledge < ActiveRecord::Migration[7.0]
  def change
    add_column :acknowledges, :uptake_motivation, :text
  end
end
