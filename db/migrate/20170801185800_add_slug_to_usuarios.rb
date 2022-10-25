# frozen_string_literal: true

class AddSlugToUsuarios < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :slug, :string
    add_index :usuarios, :slug, unique: true
  end
end
