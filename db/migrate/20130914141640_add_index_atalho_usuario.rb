class AddIndexAtalhoUsuario < ActiveRecord::Migration
  def change
    add_index :usuarios, :atalho, :unique => true
  end
end
