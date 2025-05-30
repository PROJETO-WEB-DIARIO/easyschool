class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :cpf
      t.string :rg
      t.string :nationality
      t.string :gender
      t.string :race
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :father_name
      t.string :father_name_cpf
      t.string :mother_name
      t.string :mother_name_cpf
      t.boolean :has_family_allowance
      t.boolean :has_disability
      t.boolean :requires_religious_education_exemption

      t.timestamps
    end
  end
end
