class DashboardController < ApplicationController
  def index
    @total_students = Student.count
    @total_classrooms = Classroom.count
    @total_sessions = Session.count

    # Alunos por status específico
    @total_transferidos = Student.where(status: "Transferido").count
    @total_desistentes = Student.where(status: "Desistente").count

    # 1. Alunos Ativos
    @total_ativos = Student.where(status: "Ativo").count


    # 2. Alunos com Necessidades Específicas / Condições
    @students_with_family_allowance = Student.where(has_family_allowance: true).count
    @students_with_disability = Student.where(has_disability: true).count
    @students_requiring_transport = Student.where(transport: true).count

    # 3. Métricas de Turmas
    # Média de alunos por turma
    @average_students_per_classroom = @total_classrooms > 0 ? (@total_students.to_f / @total_classrooms).round(2) : 0

    # Distribuição de turmas por série (assumindo que 'series' é um atributo de Classroom)
    # Ex: {"1º Ano" => 5, "2º Ano" => 4, "3º Ano" => 3}
    @classrooms_by_series = Classroom.group(:series).count

    # 4. Novos Cadastros (Ex: no mês corrente e no ano corrente)
    @new_students_this_month = Student.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).count
    @new_students_this_year = Student.where(created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year).count



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
