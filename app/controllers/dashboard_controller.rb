class DashboardController < ApplicationController
  def index
    @total_alunos = Aluno.count
    @total_classrooms = Classroom.count
    @total_sessions = Session.count

    # Distribuição de sexo dos alunos
    @sexo_distribution = Aluno.group(:sexo).count

    # Calculando a idade dos alunos, ignorando alunos sem data de nascimento
    @idade_distribution = Aluno.all.group_by do |aluno|
      next if aluno.data_nascimento.nil?
      Date.today.year - aluno.data_nascimento.year
    end.compact

    @idade_distribution = @idade_distribution.transform_values(&:count)
  end
end
