class DashboardController < ApplicationController
  def index
    @total_alunos = Aluno.count
    @total_classrooms = Classroom.count
    @total_sessions = Session.count

    # Exemplo de @sexo_distribution
    @sexo_distribution = { "Masculino" => 120, "Feminino" => 100 }
  end
end
