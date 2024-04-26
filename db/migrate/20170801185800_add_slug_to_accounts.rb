# frozen_string_literal: true

class AddSlugToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :slug, :string
    add_index :accounts, :slug, unique: true
  end
end
