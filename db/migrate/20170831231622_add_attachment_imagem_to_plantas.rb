class AddAttachmentImagemToPlantas < ActiveRecord::Migration[5.1]
  def self.up
    change_table :plantas do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :plantas, :imagem
  end
end
