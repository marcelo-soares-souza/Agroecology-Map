# frozen_string_literal: true

class AddLocalToComentario < ActiveRecord::Migration[7.1]
  def change
    add_reference :comentarios, :local, null: true, foreign_key: true
  end
end
