# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :account, null: false, foreign_key: true
      t.references :practice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
