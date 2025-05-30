class AddDateOfBirthToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :date_of_birth, :date
  end
end
