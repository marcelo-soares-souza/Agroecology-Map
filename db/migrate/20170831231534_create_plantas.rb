# frozen_string_literal: true

class CreatePlantas < ActiveRecord::Migration[5.1]
  def change
    create_table :plantas do |t|
      t.string :nome
      t.string :slug
      t.string :nome_cientifico
      t.text :observacao
      t.references :usuario, foreign_key: true

      t.timestamps
    end
    add_index :plantas, :slug, unique: true
  end
end
