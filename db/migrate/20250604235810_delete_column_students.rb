class DeleteColumnStudents < ActiveRecord::Migration[7.1] # ou a versão correta do seu projeto
  def change
    remove_column :students, :race
    remove_column :students, :father_name_cpf
    remove_column :students, :mother_name_cpf
  end
end
