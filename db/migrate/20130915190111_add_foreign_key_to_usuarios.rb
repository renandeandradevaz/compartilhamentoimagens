class AddForeignKeyToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :imagem_avatar_id, :integer
  end
end
