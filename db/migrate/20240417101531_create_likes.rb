# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :location, null: true, foreign_key: true
      t.references :practice, null: true, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
