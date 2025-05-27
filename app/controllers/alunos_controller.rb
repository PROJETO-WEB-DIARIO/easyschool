class AlunosController < ApplicationController
  before_action :set_aluno, only: %i[ show edit update destroy ]

  # GET /alunos or /alunos.json
  def index
    @alunos = Aluno.all
  end

  # GET /alunos/1 or /alunos/1.json
  def show
  end

  # GET /alunos/new
  def new
    @aluno = Aluno.new
  end

  # GET /alunos/1/edit
  def edit
  end

  # POST /alunos or /alunos.json
  def create
    @aluno = Aluno.new(aluno_params)

    respond_to do |format|
      if @aluno.save
        format.html { redirect_to @aluno, notice: "Aluno Criado com Sucesso." }
        format.json { render :show, status: :created, location: @aluno }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alunos/1 or /alunos/1.json
  def update
    respond_to do |format|
      if @aluno.update(aluno_params)
        format.html { redirect_to @aluno, notice: "Aluno Atualizado com Sucesso." }
        format.json { render :show, status: :ok, location: @aluno }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1 or /alunos/1.json
  def destroy
    @aluno.destroy!

    respond_to do |format|
      format.html { redirect_to alunos_path, status: :see_other, notice: "Aluno Excluido com Sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aluno
      @aluno = Aluno.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def aluno_params
      params.expect(aluno: [ :nome, :nacionalidade, :municipio_nascimento, :uf_nascimento, :data_nascimento, :sexo, :cor_raca, :nome_mae, :cpf_mae, :rg_mae, :funcao_mae, :nome_pai, :cpf_pai, :rg_pai, :funcao_pai ])
    end
end
