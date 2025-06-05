class AddColumnFatherOccupation < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :father_occupation, :string
  end
end
