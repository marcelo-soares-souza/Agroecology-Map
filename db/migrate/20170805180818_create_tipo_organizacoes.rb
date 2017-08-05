class CreateTipoOrganizacoes < ActiveRecord::Migration[5.1]
  def change
    create_table :tipo_organizacoes do |t|
      t.string :nome
      t.string :slug
      t.references :usuario, foreign_key: true

      t.timestamps
    end
    add_index :tipo_organizacoes, :slug, unique: true
  end
end
