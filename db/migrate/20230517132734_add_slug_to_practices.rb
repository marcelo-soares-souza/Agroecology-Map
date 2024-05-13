# frozen_string_literal: true

class AddSlugToPractices < ActiveRecord::Migration[7.0]
  def change
    add_column :practices, :slug, :string
    add_index :practices, :slug, unique: true
  end
end
