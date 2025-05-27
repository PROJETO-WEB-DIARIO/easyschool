require "application_system_test_case"

class AlunosTest < ApplicationSystemTestCase
  setup do
    @aluno = alunos(:one)
  end

  test "visiting the index" do
    visit alunos_url
    assert_selector "h1", text: "Alunos"
  end

  test "should create aluno" do
    visit alunos_url
    click_on "New aluno"

    fill_in "Cor raca", with: @aluno.cor_raca
    fill_in "Cpf mae", with: @aluno.cpf_mae
    fill_in "Cpf pai", with: @aluno.cpf_pai
    fill_in "Data nascimento", with: @aluno.data_nascimento
    fill_in "Funcao mae", with: @aluno.funcao_mae
    fill_in "Funcao pai", with: @aluno.funcao_pai
    fill_in "Municipio nascimento", with: @aluno.municipio_nascimento
    fill_in "Nacionalidade", with: @aluno.nacionalidade
    fill_in "Nome", with: @aluno.nome
    fill_in "Nome mae", with: @aluno.nome_mae
    fill_in "Nome pai", with: @aluno.nome_pai
    fill_in "Rg mae", with: @aluno.rg_mae
    fill_in "Rg pai", with: @aluno.rg_pai
    fill_in "Sexo", with: @aluno.sexo
    fill_in "Uf nascimento", with: @aluno.uf_nascimento
    click_on "Create Aluno"

    assert_text "Aluno was successfully created"
    click_on "Back"
  end

  test "should update Aluno" do
    visit aluno_url(@aluno)
    click_on "Edit this aluno", match: :first

    fill_in "Cor raca", with: @aluno.cor_raca
    fill_in "Cpf mae", with: @aluno.cpf_mae
    fill_in "Cpf pai", with: @aluno.cpf_pai
    fill_in "Data nascimento", with: @aluno.data_nascimento
    fill_in "Funcao mae", with: @aluno.funcao_mae
    fill_in "Funcao pai", with: @aluno.funcao_pai
    fill_in "Municipio nascimento", with: @aluno.municipio_nascimento
    fill_in "Nacionalidade", with: @aluno.nacionalidade
    fill_in "Nome", with: @aluno.nome
    fill_in "Nome mae", with: @aluno.nome_mae
    fill_in "Nome pai", with: @aluno.nome_pai
    fill_in "Rg mae", with: @aluno.rg_mae
    fill_in "Rg pai", with: @aluno.rg_pai
    fill_in "Sexo", with: @aluno.sexo
    fill_in "Uf nascimento", with: @aluno.uf_nascimento
    click_on "Update Aluno"

    assert_text "Aluno was successfully updated"
    click_on "Back"
  end

  test "should destroy Aluno" do
    visit aluno_url(@aluno)
    accept_confirm { click_on "Destroy this aluno", match: :first }

    assert_text "Aluno was successfully destroyed"
  end
end
