# frozen_string_literal: true

class AddAccountToDocument < ActiveRecord::Migration[7.0]
  def change
    add_reference :documents, :account, null: false, foreign_key: true
  end
end
