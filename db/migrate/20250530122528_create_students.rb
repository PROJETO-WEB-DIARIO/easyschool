class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :status
      t.string :email
      t.string :cpf
      t.string :rg
      t.string :nationality
      t.string :gender
      t.string :skin_color_or_race
      t.string :phone
      t.string :address
      t.string :birth_city
      t.string :birth_state
      t.string :zip_code
      t.string :father_name
      t.string :father_cpf
      t.string :father_rg
      t.string :father_occupation
      t.string :mother_name
      t.string :mother_cpf
      t.string :mother_rg
      t.string :mother_occupation
      t.date :date_of_birth
      t.boolean :has_family_allowance
      t.boolean :has_disability
      t.boolean :requires_religious_education_exemption
      t.boolean :transport

      t.timestamps
    end
  end
end
