class AddAttachmentImagemToAnimais < ActiveRecord::Migration[5.1]
  def self.up
    change_table :animais do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :animais, :imagem
  end
end
