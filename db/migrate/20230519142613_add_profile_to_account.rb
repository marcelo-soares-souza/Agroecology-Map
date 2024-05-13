# frozen_string_literal: true

class AddProfileToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :about, :text
    add_column :accounts, :website, :string
  end
end
