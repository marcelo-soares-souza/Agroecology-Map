class AddAdminToUsuarios < ActiveRecord::Migration[5.1]
  def change
    add_column :usuarios, :admin, :boolean, default: false
  end
end
