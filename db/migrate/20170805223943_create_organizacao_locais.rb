# frozen_string_literal: true

class CreateOrganizacaoLocais < ActiveRecord::Migration[5.1]
  def change
    create_table :organizacao_locais do |t|
      t.references :organizacao, foreign_key: true
      t.references :local, foreign_key: true

      t.timestamps
    end
  end
end
