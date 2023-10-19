# frozen_string_literal: true

class AddCountryToLocal < ActiveRecord::Migration[7.1]
  def change
    add_column :locais, :country, :string
  end
end
