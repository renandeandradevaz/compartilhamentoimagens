class AddAtalhoToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :atalho, :string
  end
end
