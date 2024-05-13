# frozen_string_literal: true

class AddIndexToLocations < ActiveRecord::Migration[7.0]
  def up
    enable_extension("pg_trgm")
    add_index(:locations, :name, using: "gin", opclass: :gin_trgm_ops)
    add_index(:practices, :name, using: "gin", opclass: :gin_trgm_ops)
    add_index(:accounts,  :name, using: "gin", opclass: :gin_trgm_ops)
  end

  def down
    remove_index(:locations, :name)
    remove_index(:practices, :name)
    remove_index(:accounts, :name)
  end
end
