json.extract! student, :id, :name, :email, :cpf, :rg, :nationality, :gender, :race, :phone, :address, :city, :state, :zip_code, :father_name, :father_name_cpf, :mother_name, :mother_name_cpf, :has_family_allowance, :has_disability, :requires_religious_education_exemption, :created_at, :updated_at
json.url student_url(student, format: :json)
