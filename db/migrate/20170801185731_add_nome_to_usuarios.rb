# frozen_string_literal: true

class AddNomeToUsuarios < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :nome, :string
  end
end
