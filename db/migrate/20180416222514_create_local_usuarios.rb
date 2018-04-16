class CreateLocalUsuarios < ActiveRecord::Migration[5.1]
  def change
    create_table :local_usuarios do |t|
      t.references :local, foreign_key: true
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
