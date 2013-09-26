class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|

      t.string :comentario
      t.integer :usuario_id, :null => false
      t.integer :imagem_id, :null => false
      t.timestamps
    end
    add_foreign_key(:comentarios, :usuarios)
    add_foreign_key(:comentarios, :imagems)
  end
end
