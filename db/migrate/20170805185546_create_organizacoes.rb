class CreateOrganizacoes < ActiveRecord::Migration[5.1]
  def change
    create_table :organizacoes do |t|
      t.string :nome
      t.string :slug
      t.string :sigla
      t.references :tipo_organizacao, foreign_key: true
      t.string :email
      t.string :telefone
      t.string :site
      t.text :descricao
      t.string :cidade
      t.string :uf
      t.string :pais
      t.float :latitude
      t.float :longitude
      t.string :observacao
      t.references :usuario, foreign_key: true

      t.timestamps
    end
    add_index :organizacoes, :slug, unique: true
    add_index :organizacoes, :email, unique: true
  end
end
