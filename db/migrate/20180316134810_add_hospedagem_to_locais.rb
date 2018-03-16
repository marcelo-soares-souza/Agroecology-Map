class AddHospedagemToLocais < ActiveRecord::Migration[5.1]
  def change
    add_column :locais, :hospedagem, :string
  end
end
