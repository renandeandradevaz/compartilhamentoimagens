class ChangeColumnType < ActiveRecord::Migration
  def change
      change_column :usuarios, :informacoesPessoais, :text
  end
end
