json.extract! student, :id, :name, :email, :date_of_birth, :cpf, :rg, :nationality, :birth_city, :birth_state, :gender, :skin_color_or_race, :phone, :address, :city,
:father_name, :father_cpf, :father_rg, :father_occupation, :state, :zip_code, :mother_name, :mother_cpf, :mother_rg, :mother_occupation, :has_family_allowance, :has_disability, :requires_religious_education_exemption, :created_at, :updated_at
json.url student_url(student, format: :json)
