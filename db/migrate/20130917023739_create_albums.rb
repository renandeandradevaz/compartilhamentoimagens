class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :nome
      t.integer :usuario_id, :null => false
      t.timestamps
    end
    add_foreign_key(:albums, :usuarios)
  end
end
