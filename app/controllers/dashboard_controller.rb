class DashboardController < ApplicationController
  def index
    @total_students = Student.count
    @total_classrooms = Classroom.count
    @total_sessions = Session.count

    # Alunos por status específico
    @total_transferidos = Student.where(status: "Transferido").count
    @total_desistentes = Student.where(status: "Desistente").count

    # Distribuição de sexo dos alunos
    @gender_distribution = Student.group(:gender).count

    # Distribuição de idade
    @age_distribution = Student.all.group_by do |student|
      next if student.date_of_birth.nil?
      Date.today.year - student.date_of_birth.year
    end.compact

    @age_distribution = @age_distribution.transform_values(&:count)
  end
end
