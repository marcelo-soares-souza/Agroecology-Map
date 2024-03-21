# frozen_string_literal: true

class AddPracticeToMedia < ActiveRecord::Migration[7.0]
  def change
    add_reference :medias, :practice,  foreign_key: true
  end
end
