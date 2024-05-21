# frozen_string_literal: true

class AddVisitsToPractice < ActiveRecord::Migration[7.1]
  def change
    add_column :practices, :visits, :integer, default: 0
  end
end
