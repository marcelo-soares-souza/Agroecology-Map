# frozen_string_literal: true

class AddWebsiteToUsuario < ActiveRecord::Migration[7.1]
  def change
    add_column :usuarios, :website, :string
  end
end
