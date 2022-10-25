# frozen_string_literal: true

class AddAttachmentImagemToMidias < ActiveRecord::Migration[5.1]
  def self.up
    change_table :midias do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :midias, :imagem
  end
end
