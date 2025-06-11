class ClassroomsController < ApplicationController
  before_action :set_classroom, only: %i[ show edit update destroy ]

  # GET /classrooms or /classrooms.json
  def index
    @classrooms = Classroom.includes(:students).all
  end

  # GET /classrooms/1 or /classrooms/1.json
  def show
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms or /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: "Turma Criada com Sucesso." }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1 or /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: "Turma Atualizada com Sucesso." }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1 or /classrooms/1.json
  def destroy
    if @classroom.students.any?
      respond_to do |format|
        format.html { redirect_to classrooms_url, alert: "Não foi possível excluir a turma '#{@classroom.name}' porque ela ainda possui alunos vinculados." }
        format.json { render json: { error: "Não é possível excluir a turma porque ela ainda possui alunos vinculados." }, status: :unprocessable_entity }
      end
    else
      @classroom.destroy!

      respond_to do |format|
        format.html { redirect_to classrooms_url, notice: "Turma '#{@classroom.name}' foi excluída com sucesso." }
        format.json { head :no_content }
      end
    end
  end

def export_students_pdf
    @classroom = Classroom.find(params[:id])
    @students = @classroom.students.order(:name) # Pega todos os alunos da turma, ordenados por nome

    pdf = Prawn::Document.new(page_size: "A4", margin: [ 40, 40, 40, 40 ]) # Layout padrão é portrait

    # --- Início do Cabeçalho (Timbre para retrato) ---
    portrait_header_path = Rails.root.join("app", "assets", "images", "cabecalho2.png")

    if File.exist?(portrait_header_path)
      # Posição e largura do timbre. Ajuste 'at' e 'width' conforme sua imagem.
      pdf.image portrait_header_path, at: [ pdf.bounds.left, pdf.bounds.top + 20 ], width: pdf.bounds.width
    end
    # Ajuste para dar espaço ao cabeçalho. Teste este valor.
    pdf.move_down 70

    # --- Fim do Cabeçalho ---

    pdf.text "Lista de Alunos da Turma: #{@classroom.name}", size: 22, style: :bold, align: :center
    pdf.text "Ano Letivo: #{@classroom.year} - Série: #{@classroom.series}", size: 14, align: :center
    pdf.move_down 20

    if @students.any?
      # Define os dados da tabela
      table_data = [
        [ "Nº", "Nome Completo", "Data Nasc.", "Sexo", "CPF", "RG", "Email", "Status" ]
      ]

      @students.each_with_index do |student, index|
        table_data << [
          (index + 1).to_s, # Converte o número para string
          student.name.to_s.upcase, # Garante string e maiúscula
          student.date_of_birth&.strftime("%d/%m/%Y").to_s, # Garante string
          student.gender.to_s, # Garante string
          student.cpf.to_s,    # Garante string
          student.rg.to_s,     # Garante string
          student.email.to_s,  # Garante string
          student.status.to_s  # Garante string
        ]
      end

      # Usando o estilo de tabela do seu `export_all_pdf`
      pdf.table(table_data, header: true, row_colors: [ "F0F0F0", "FFFFFF" ], cell_style: { size: 10, padding: [ 4, 4, 4, 4 ] }) do
        row(0).font_style = :bold
        row(0).background_color = "CCCCCC"
        self.header = true
        self.position = :center # Centraliza a tabela na página

        # Adicionando alinhamentos como no seu exemplo anterior, se desejar
        columns(0).align = :center # Alinha o número ao centro
        columns(1).align = :left   # Alinha o nome à esquerda
        columns(2..-1).align = :center # Alinha as outras colunas ao centro

        # Ajuste de fonte para as linhas de dados, se 10 for muito grande
        rows(1..-1).font_size = 7 # Pode ajustar para 8 ou 9 se houver espaço
      end

    else
      pdf.text "Nenhum aluno matriculado nesta turma.", align: :center, style: :italic, size: 12
    end

    send_data pdf.render,
              filename: "alunos_turma_#{@classroom.name.parameterize}.pdf",
              type: "application/pdf",
              disposition: "inline"
end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
      # Se você vai exibir os alunos na página show, adicione includes aqui também
      # @classroom = Classroom.includes(:students).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classroom_params
      params.expect(classroom: [ :name, :year, :series ])
    end
end
