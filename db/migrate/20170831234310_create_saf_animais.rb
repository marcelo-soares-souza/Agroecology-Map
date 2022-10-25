# frozen_string_literal: true

class CreateSafAnimais < ActiveRecord::Migration[5.1]
  def change
    create_table :saf_animais do |t|
      t.references :saf, foreign_key: true
      t.references :animal, foreign_key: true

      t.timestamps
    end
  end
end
