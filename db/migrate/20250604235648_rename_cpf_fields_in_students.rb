class RenameCpfFieldsInStudents < ActiveRecord::Migration[7.1]
  def change
    rename_column :students, :father_name_cpf, :father_cpf
  end
end
