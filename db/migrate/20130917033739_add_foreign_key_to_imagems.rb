class AddForeignKeyToImagems < ActiveRecord::Migration
  def change
    add_column :imagems, :album_id, :integer
    add_foreign_key(:imagems, :albums)
  end
end
