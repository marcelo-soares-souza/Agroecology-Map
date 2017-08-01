class AddAttachmentImagemToUsuarios < ActiveRecord::Migration[5.1]
  def self.up
    change_table :usuarios do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :usuarios, :imagem
  end
end
