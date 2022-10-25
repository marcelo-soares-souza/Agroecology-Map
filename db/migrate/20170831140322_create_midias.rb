# frozen_string_literal: true

class CreateMidias < ActiveRecord::Migration[5.1]
  def change
    create_table :midias do |t|
      t.string :descricao
      t.string :slug
      t.references :saf, foreign_key: true
      t.references :experiencia_agroecologica, foreign_key: true

      t.timestamps
    end
    add_index :midias, :slug, unique: true
  end
end
