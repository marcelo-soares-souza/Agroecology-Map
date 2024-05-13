# frozen_string_literal: true

class AddAdminToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :admin, :boolean, default: false
  end
end
