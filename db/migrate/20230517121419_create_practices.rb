# frozen_string_literal: true

class CreatePractices < ActiveRecord::Migration[7.0]
  def change
    create_table :practices do |t|
      t.references :account, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.text :name

      t.timestamps
    end
  end
end
