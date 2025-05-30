class DashboardController < ApplicationController
  def index
    @total_students = Student.count
    @total_classrooms = Classroom.count
    @total_sessions = Session.count

    # Distribuição de sexo dos alunos
    @gender_distribution = Student.group(:gender).count

    # Calculando a idade dos alunos, ignorando alunos sem data de nascimento
    @age_distribution = Student.all.group_by do |student|
      next if student.date_of_birth.nil?
      Date.today.year - student.date_of_birth.year
    end.compact

    @age_distribution = @age_distribution.transform_values(&:count)
  end
end
