class CreateTemaExperienciaAgroecologicas < ActiveRecord::Migration[5.1]
  def change
    create_table :tema_experiencia_agroecologicas do |t|
      t.string :nome
      t.string :slug
      t.references :usuario, foreign_key: true

      t.timestamps
    end
    add_index :tema_experiencia_agroecologicas, :slug, unique: true
  end
end
