# frozen_string_literal: true

class CreateExperienciaAgroecologicas < ActiveRecord::Migration[5.1]
  def change
    create_table :experiencia_agroecologicas do |t|
      t.string :nome
      t.string :slug
      t.references :usuario, foreign_key: true
      t.references :local, foreign_key: true
      t.references :tema_experiencia_agroecologica, foreign_key: true,
                                                    index: { name: "idx_exp_agroecologicas_on_tema_exp_agroecologica_id" }
      t.text :resumo
      t.text :observacao

      t.timestamps
    end
    add_index :experiencia_agroecologicas, :slug, unique: true
  end
end
