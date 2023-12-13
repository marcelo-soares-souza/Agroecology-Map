# frozen_string_literal: true

class AddLocalToLike < ActiveRecord::Migration[7.1]
  def change
    add_reference :likes, :local, null: true, foreign_key: true
  end
end
