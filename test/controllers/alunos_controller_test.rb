require "test_helper"

class AlunosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aluno = alunos(:one)
  end

  test "should get index" do
    get alunos_url
    assert_response :success
  end

  test "should get new" do
    get new_aluno_url
    assert_response :success
  end

  test "should create aluno" do
    assert_difference("Aluno.count") do
      post alunos_url, params: { aluno: { cor_raca: @aluno.cor_raca, cpf_mae: @aluno.cpf_mae, cpf_pai: @aluno.cpf_pai, data_nascimento: @aluno.data_nascimento, funcao_mae: @aluno.funcao_mae, funcao_pai: @aluno.funcao_pai, municipio_nascimento: @aluno.municipio_nascimento, nacionalidade: @aluno.nacionalidade, nome: @aluno.nome, nome_mae: @aluno.nome_mae, nome_pai: @aluno.nome_pai, rg_mae: @aluno.rg_mae, rg_pai: @aluno.rg_pai, sexo: @aluno.sexo, uf_nascimento: @aluno.uf_nascimento } }
    end

    assert_redirected_to aluno_url(Aluno.last)
  end

  test "should show aluno" do
    get aluno_url(@aluno)
    assert_response :success
  end

  test "should get edit" do
    get edit_aluno_url(@aluno)
    assert_response :success
  end

  test "should update aluno" do
    patch aluno_url(@aluno), params: { aluno: { cor_raca: @aluno.cor_raca, cpf_mae: @aluno.cpf_mae, cpf_pai: @aluno.cpf_pai, data_nascimento: @aluno.data_nascimento, funcao_mae: @aluno.funcao_mae, funcao_pai: @aluno.funcao_pai, municipio_nascimento: @aluno.municipio_nascimento, nacionalidade: @aluno.nacionalidade, nome: @aluno.nome, nome_mae: @aluno.nome_mae, nome_pai: @aluno.nome_pai, rg_mae: @aluno.rg_mae, rg_pai: @aluno.rg_pai, sexo: @aluno.sexo, uf_nascimento: @aluno.uf_nascimento } }
    assert_redirected_to aluno_url(@aluno)
  end

  test "should destroy aluno" do
    assert_difference("Aluno.count", -1) do
      delete aluno_url(@aluno)
    end

    assert_redirected_to alunos_url
  end
end
