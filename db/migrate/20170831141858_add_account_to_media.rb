# frozen_string_literal: true

class AddAccountToMedia < ActiveRecord::Migration[5.1]
  def change
    add_reference :medias, :account, foreign_key: true
  end
end
