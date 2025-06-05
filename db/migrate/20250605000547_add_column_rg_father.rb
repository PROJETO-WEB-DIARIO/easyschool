class AddColumnRgFather < ActiveRecord::Migration[7.1] # use a versão do seu projeto
  def change
    add_column :students, :father_rg, :string
  end
end
