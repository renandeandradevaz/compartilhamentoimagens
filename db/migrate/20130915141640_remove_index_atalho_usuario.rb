class RemoveIndexAtalhoUsuario < ActiveRecord::Migration
  def change
    remove_index(:usuarios, :name => 'index_usuarios_on_atalho')
  end
end
