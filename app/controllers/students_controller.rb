class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @per_page = 10 # <-- Defina quantos itens por página você quer
    @page = params[:page].to_i
    @page = 1 if @page < 1 # Garante que a página mínima seja 1

    # Adicione a lógica de pesquisa, se houver
    if params[:search].present?
      # Exemplo de pesquisa por nome ou email (ajuste conforme seus campos)
      @students = Student.where("name ILIKE ? OR email ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @students = Student.all
    end

    # Aplica a paginação
    @students = @students.limit(@per_page).offset((@page - 1) * @per_page)

    # Nota: Student.count deve ser feito ANTES de aplicar o limit/offset
    # Se você fizer Student.count depois, ele contará apenas os resultados da página atual
    @total_students_count = if params[:search].present?
                              Student.where("name ILIKE ? OR email ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").count
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
    @student.destroy!

    respond_to do |format|
      format.html { redirect_to students_path, status: :see_other, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.expect(student: [ :name, :email, :date_of_birth, :cpf, :rg, :nationality, :gender, :race, :phone, :address, :city, :state, :zip_code, :father_name, :father_name_cpf, :mother_name, :mother_name_cpf, :has_family_allowance, :has_disability, :requires_religious_education_exemption, classroom_ids: [] ])
    end
end
