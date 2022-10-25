# frozen_string_literal: true

class CreateSafs < ActiveRecord::Migration[5.1]
  def change
    create_table :safs do |t|
      t.string :nome
      t.string :slug
      t.string :objetivo
      t.string :produto_principal
      t.date :inicio
      t.date :fim
      t.string :area
      t.references :local, foreign_key: true
      t.references :usuario, foreign_key: true
      t.text :observacao

      t.timestamps
    end
    add_index :safs, :slug, unique: true
  end
end
