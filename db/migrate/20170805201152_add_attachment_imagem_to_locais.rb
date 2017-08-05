class AddAttachmentImagemToLocais < ActiveRecord::Migration[5.1]
  def self.up
    change_table :locais do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :locais, :imagem
  end
end
