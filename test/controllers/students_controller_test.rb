require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

  test "should create student" do
    assert_difference("Student.count") do
      post students_url, params: { student: { address: @student.address, city: @student.city, cpf: @student.cpf, email: @student.email, father_name: @student.father_name, father_name_cpf: @student.father_name_cpf, gender: @student.gender, has_disability: @student.has_disability, has_family_allowance: @student.has_family_allowance, mother_name: @student.mother_name, mother_name_cpf: @student.mother_name_cpf, name: @student.name, nationality: @student.nationality, phone: @student.phone, race: @student.race, requires_religious_education_exemption: @student.requires_religious_education_exemption, rg: @student.rg, state: @student.state, zip_code: @student.zip_code } }
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should show student" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { address: @student.address, city: @student.city, cpf: @student.cpf, email: @student.email, father_name: @student.father_name, father_name_cpf: @student.father_name_cpf, gender: @student.gender, has_disability: @student.has_disability, has_family_allowance: @student.has_family_allowance, mother_name: @student.mother_name, mother_name_cpf: @student.mother_name_cpf, name: @student.name, nationality: @student.nationality, phone: @student.phone, race: @student.race, requires_religious_education_exemption: @student.requires_religious_education_exemption, rg: @student.rg, state: @student.state, zip_code: @student.zip_code } }
    assert_redirected_to student_url(@student)
  end

  test "should destroy student" do
    assert_difference("Student.count", -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
