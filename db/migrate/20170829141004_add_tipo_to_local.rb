# frozen_string_literal: true

class AddTipoToLocal < ActiveRecord::Migration[5.1]
  def change
    add_column :locais, :tipo, :string
  end
end
