# frozen_string_literal: true

class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :titulo
      t.string :slug
      t.text :texto
      t.references :usuario, foreign_key: true
      t.references :local, foreign_key: true

      t.timestamps
    end
  end
end
