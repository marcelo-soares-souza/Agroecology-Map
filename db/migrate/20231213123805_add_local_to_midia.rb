# frozen_string_literal: true

class AddLocalToMidia < ActiveRecord::Migration[7.1]
  def change
    add_reference :midias, :local, null: true, foreign_key: true
  end
end
