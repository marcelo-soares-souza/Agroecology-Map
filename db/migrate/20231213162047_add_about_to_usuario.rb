class AddAboutToUsuario < ActiveRecord::Migration[7.1]
  def change
    add_column :usuarios, :about, :string
  end
end
