class AddUsuarioToMidia < ActiveRecord::Migration[5.1]
  def change
    add_reference :midias, :usuario, foreign_key: true
  end
end
