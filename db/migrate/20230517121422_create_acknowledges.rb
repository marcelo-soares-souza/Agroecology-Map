# frozen_string_literal: true

class CreateAcknowledges < ActiveRecord::Migration[7.0]
  def change
    create_table :acknowledges do |t|
      t.references :practice, null: false, foreign_key: true
      t.text :knowledge_source
      t.text :knowledge_timing
      t.text :knowledge_products

      t.timestamps
    end
  end
end
