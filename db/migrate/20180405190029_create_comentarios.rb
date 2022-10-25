# frozen_string_literal: true

class CreateComentarios < ActiveRecord::Migration[5.1]
  def change
    create_table :comentarios do |t|
      t.string :texto
      t.string :slug
      t.references :experiencia_agroecologica, foreign_key: true
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
