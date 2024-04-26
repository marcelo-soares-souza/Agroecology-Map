# frozen_string_literal: true

class AddLocationToDocument < ActiveRecord::Migration[7.0]
  def change
    add_reference :documents, :location, null: false, foreign_key: true
  end
end
