# frozen_string_literal: true

class AddLocationToMedia < ActiveRecord::Migration[7.0]
  def change
    add_reference :medias, :location, foreign_key: true
  end
end
