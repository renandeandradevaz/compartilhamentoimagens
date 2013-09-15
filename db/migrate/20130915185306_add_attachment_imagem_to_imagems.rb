class AddAttachmentImagemToImagems < ActiveRecord::Migration
  def self.up
    change_table :imagems do |t|
      t.attachment :imagem
    end
  end

  def self.down
    drop_attached_file :imagems, :imagem
  end
end
