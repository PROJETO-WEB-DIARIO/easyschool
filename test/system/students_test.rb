require "application_system_test_case"

class StudentsTest < ApplicationSystemTestCase
  setup do
    @student = students(:one)
  end

  test "visiting the index" do
    visit students_url
    assert_selector "h1", text: "Students"
  end

  test "should create student" do
    visit students_url
    click_on "New student"

    fill_in "Address", with: @student.address
    fill_in "City", with: @student.city
    fill_in "Cpf", with: @student.cpf
    fill_in "Email", with: @student.email
    fill_in "Father name", with: @student.father_name
    fill_in "Father name cpf", with: @student.father_name_cpf
    fill_in "Gender", with: @student.gender
    check "Has disability" if @student.has_disability
    check "Has family allowance" if @student.has_family_allowance
    fill_in "Mother name", with: @student.mother_name
    fill_in "Mother name cpf", with: @student.mother_name_cpf
    fill_in "Name", with: @student.name
    fill_in "Nationality", with: @student.nationality
    fill_in "Phone", with: @student.phone
    fill_in "Race", with: @student.race
    check "Requires religious education exemption" if @student.requires_religious_education_exemption
    fill_in "Rg", with: @student.rg
    fill_in "State", with: @student.state
    fill_in "Zip code", with: @student.zip_code
    click_on "Create Student"

    assert_text "Student was successfully created"
    click_on "Back"
  end

  test "should update Student" do
    visit student_url(@student)
    click_on "Edit this student", match: :first

    fill_in "Address", with: @student.address
    fill_in "City", with: @student.city
    fill_in "Cpf", with: @student.cpf
    fill_in "Email", with: @student.email
    fill_in "Father name", with: @student.father_name
    fill_in "Father name cpf", with: @student.father_name_cpf
    fill_in "Gender", with: @student.gender
    check "Has disability" if @student.has_disability
    check "Has family allowance" if @student.has_family_allowance
    fill_in "Mother name", with: @student.mother_name
    fill_in "Mother name cpf", with: @student.mother_name_cpf
    fill_in "Name", with: @student.name
    fill_in "Nationality", with: @student.nationality
    fill_in "Phone", with: @student.phone
    fill_in "Race", with: @student.race
    check "Requires religious education exemption" if @student.requires_religious_education_exemption
    fill_in "Rg", with: @student.rg
    fill_in "State", with: @student.state
    fill_in "Zip code", with: @student.zip_code
    click_on "Update Student"

    assert_text "Student was successfully updated"
    click_on "Back"
  end

  test "should destroy Student" do
    visit student_url(@student)
    accept_confirm { click_on "Destroy this student", match: :first }

    assert_text "Student was successfully destroyed"
  end
end
