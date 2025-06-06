class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @per_page = 10 # <-- Defina quantos itens por página você quer
    @page = params[:page].to_i
    @page = 1 if @page < 1 # Garante que a página mínima seja 1

    # Adicione a lógica de pesquisa, se houver
    if params[:search].present?
      # ALTERE AQUI: Mude ILIKE para LIKE
      @students = Student.where("name LIKE ? OR email LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @students = Student.all
    end

    # Aplica a paginação
    @students = @students.limit(@per_page).offset((@page - 1) * @per_page)

    @total_students_count = if params[:search].present?
                              # ALTERE AQUI: Mude ILIKE para LIKE
                              Student.where("name LIKE ? OR email LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").count
    else
                              Student.count
    end
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    if @student.enrollments.any? || @student.transfers.any?
      redirect_to students_path, alert: "Não é possível excluir um aluno com matrículas ou transferências."
    else
      @student.destroy
      redirect_to students_path, notice: "Aluno excluído com sucesso."
    end
  end

  def export_pdf
  @student = Student.find(params[:id])

  pdf = Prawn::Document.new

  pdf.text "Detalhes do Aluno", size: 24, style: :bold, align: :center
  pdf.move_down 20

  pdf.text "Nome: #{@student.name}", size: 12
  pdf.text "Nascimento: #{@student.date_of_birth.strftime('%d/%m/%Y') if @student.date_of_birth}", size: 12
  pdf.text "Município de Nascimento: #{@student.city}", size: 12
  pdf.text "UF: #{@student.state}", size: 12
  pdf.text "Sexo: #{@student.gender}", size: 12

  # Exibir turmas
  if @student.classrooms.any?
    pdf.move_down 10
    pdf.text "Turmas:", size: 12, style: :bold
    @student.classrooms.each do |classroom|
      pdf.text "- #{classroom.name}", size: 12
    end
  else
    pdf.text "Turmas: Nenhuma", size: 12
  end

  send_data pdf.render,
            filename: "aluno_#{@student.id}.pdf",
            type: "application/pdf",
            disposition: "inline"  # ou "attachment" para download
  end

  def export_all_pdf
  students = if params[:search].present?
             Student.where("name ILIKE ?", "%#{params[:search]}%")
  else
             Student.all
  end

  pdf = Prawn::Document.new
  pdf.text "Lista de Alunos", size: 24, style: :bold, align: :center
  pdf.move_down 20

  table_data = [ [ "Nome", "Nascimento", "Turma(s)", "Município", "UF", "Sexo" ] ]

  students.each do |s|
    table_data << [
      s.name,
      s.date_of_birth&.strftime("%d/%m/%Y") || "-",
      s.classrooms.any? ? s.classrooms.map(&:name).join(", ") : "Sem turma",
      s.city,
      s.state,
      s.gender
    ]
  end

  pdf.table(table_data, header: true, row_colors: [ "F0F0F0", "FFFFFF" ], cell_style: { size: 10 }) do
    row(0).font_style = :bold
    row(0).background_color = "CCCCCC"
    self.header = true
    self.position = :center
  end

  send_data pdf.render,
            filename: "alunos.pdf",
            type: "application/pdf",
            disposition: "inline"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name,:status, :email, :date_of_birth, :cpf, :rg, :nationality, :birth_city, :birth_state, :gender, :skin_color_or_race, :phone, :address, :city, :state, :father_name, :father_cpf, :father_rg, :father_occupation, :zip_code, :mother_name, :mother_cpf, :mother_rg, :mother_occupation, :has_family_allowance, :has_disability, :requires_religious_education_exemption, :transport,  classroom_ids: [])
    end
end
