class CreateLocais < ActiveRecord::Migration[5.1]
  def change
    create_table :locais do |t|
      t.string :nome
      t.string :slug
      t.string :observacao
      t.float :latitude
      t.float :longitude
      t.references :usuario, foreign_key: true

      t.timestamps
    end
    add_index :locais, :slug, unique: true
  end
end
