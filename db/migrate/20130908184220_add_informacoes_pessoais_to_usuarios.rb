class AddInformacoesPessoaisToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :informacoesPessoais, :string
  end
end
