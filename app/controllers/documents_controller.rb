# app/controllers/documents_controller.rb

class DocumentsController < ApplicationController
  before_action :set_common_variables, only: [ :generate ]

  def index
    @classrooms = Classroom.all.order(:name)
  end

  def generate
    case params[:document_type]
    when "frequencia"
      generate_frequency_sheet
    when "notas"
      generate_grades_sheet
    else
      redirect_to documents_path, alert: "Tipo de documento inválido"
    end
  end

  private

  def set_common_variables
    @classroom = Classroom.find(params[:classroom_id])
    @students = @classroom.students.order(:name)
    @professor = params[:professor].presence || "_________________________"
    @discipline = params[:discipline].presence || "______________"
  end

  def generate_frequency_sheet
    # --- INÍCIO DA LÓGICA DE DIAS DINÂMICOS ---

    month_name = params[:month].presence || "_________________"
    year = Time.now.year # O ano que estamos usando, importante para anos bissextos (Fevereiro)

    # NOVO: Converte o nome do mês (em português) para um número de 1 a 12
    month_number = case month_name.downcase
    when "janeiro" then 1
    when "fevereiro" then 2
    when "março" then 3
    when "abril" then 4
    when "maio" then 5
    when "junho" then 6
    when "julho" then 7
    when "agosto" then 8
    when "setembro" then 9
    when "outubro" then 10
    when "novembro" then 11
    when "dezembro" then 12
    end

    # NOVO: Calcula o número de dias no mês. Se o mês for inválido, assume 30 dias.
    if month_number
      days_in_month = Time.days_in_month(month_number, year)
    else
      days_in_month = 30 # Valor padrão
    end

    # --- FIM DA LÓGICA DE DIAS DINÂMICOS ---


    pdf = Prawn::Document.new(page_size: "A4", page_layout: :landscape, margin: [ 40, 40, 40, 40 ])

    # O cabeçalho continua igual...
    logo_path = Rails.root.join("app", "assets", "images", "logo_escola.jpg")
    pdf.bounding_box([ 85, pdf.cursor ], width: 200, height: 50) do
      pdf.text "ESCOLA MUNICIPAL", size: 14, style: :bold
      pdf.text "06 DE MARÇO", size: 14, style: :bold
    end
    pdf.image(logo_path, at: [ 0, pdf.cursor + 50 ], width: 70) if File.exist?(logo_path)
    pdf.move_down 10
    pdf.text "Folha de Frequência 2025", size: 18, style: :bold, align: :center
    pdf.move_down 20
    info_data = [
      [ "Professor(a): #{@professor}", "Mês: #{month_name}" ],
      [ "Turma: #{@classroom.name}",  "Disciplina: #{@discipline}" ]
    ]
    pdf.table(info_data, width: pdf.bounds.width) do
      cells.border_width = 0
      cells.padding = [ 2, 0, 2, 0 ]
      column(0).width = width / 2
      column(1).width = width / 2
    end
    pdf.move_down(20)


    # --- INÍCIO DA TABELA DINÂMICA ---

    # ALTERADO: Usa a variável 'days_in_month' para criar o cabeçalho
    header = [ "Nº", "NOME DO ALUNO" ] + (1..days_in_month).to_a.map(&:to_s)
    table_data = [ header ]

    # ALTERADO: Usa a variável 'days_in_month' para criar as linhas
    @students.each_with_index do |student, i|
      student_row = [ "%02d" % (i + 1), student.name.upcase ]
      table_data << (student_row + Array.new(days_in_month, ""))
    end

    # ALTERADO: Ajusta a largura da coluna de nome para caber 31 dias
    name_column_width = 180
    day_column_width = 17.5
    column_widths = [ 30, name_column_width ] + ([ day_column_width ] * days_in_month)

    # ALTERADO: Usa a variável 'days_in_month' para definir o estilo das colunas
    last_day_column_index = 1 + days_in_month

    pdf.table(table_data, header: true, column_widths: column_widths) do
      cells.padding = [ 4, 4, 4, 4 ]
      cells.align = :center

      row(0).font_style = :bold
      row(0).background_color = "eeeeee"
      row(0).columns(2..last_day_column_index).font_size = 8
      row(0).columns(2..last_day_column_index).padding = [ 4, 2, 4, 2 ]

      columns(1).align = :left

      rows(1..-1).height = 20
      rows(1..-1).font_size = 8
    end
    # --- FIM DA TABELA DINÂMICA ---

    render_pdf(pdf, "frequencia_#{@classroom.name.parameterize}.pdf")
  end

  def generate_grades_sheet
    bimestre = params[:bimestre].presence || "______________"

    # Página em paisagem para caber todas as colunas de notas
    pdf = Prawn::Document.new(page_size: "A4", page_layout: :landscape, margin: [ 40, 40, 40, 40 ])

    # Reutilizando a mesma lógica de cabeçalho
    logo_path = Rails.root.join("app", "assets", "images", "logo.png")
    pdf.bounding_box([ 85, pdf.cursor ], width: 200, height: 50) do
      pdf.text "ESCOLA MUNICIPAL", size: 14, style: :bold
      pdf.text "06 DE MARÇO", size: 14, style: :bold
    end
    pdf.image(logo_path, at: [ 0, pdf.cursor + 50 ], width: 70) if File.exist?(logo_path)
    pdf.move_down 10
    pdf.text "Folha de Notas 2025", size: 18, style: :bold, align: :center # Título alterado
    pdf.move_down 20
    # Usando a variável 'bimestre'
    info_data = [
      [ "Professor(a): #{@professor}", "Bimestre: #{bimestre}" ],
      [ "Turma: #{@classroom.name}",  "Disciplina: #{@discipline}" ]
    ]
    pdf.table(info_data, width: pdf.bounds.width) do
      cells.border_width = 0; cells.padding = [ 2, 0, 2, 0 ]
      column(0).width = width / 2; column(1).width = width / 2
    end
    pdf.move_down(20)

    # Construção da tabela de notas
    header = [ "Nº", "NOME DO ALUNO", "1º RP", "2º RP", "3º RP", "4º RP", "5º RP", "1ª NOTA", "2ª NOTA", "MB" ]
    table_data = [ header ]

    @students.each_with_index do |student, i|
      # Adiciona o aluno e 8 colunas vazias para as notas
      table_data << ([ "%02d" % (i + 1), student.name.upcase ] + Array.new(8, ""))
    end

    # Define a largura para as 10 colunas
    grade_column_width = 60
    column_widths = [ 30, 250 ] + ([ grade_column_width ] * 8)

    pdf.table(table_data, header: true, column_widths: column_widths) do
      # Estilo geral
      cells.padding = [ 4, 4, 4, 4 ]
      cells.align = :center

      # Estilo do cabeçalho
      row(0).font_style = :bold
      row(0).background_color = "eeeeee"
      row(0).font_size = 9 # Fonte um pouco menor para caber melhor

      # Estilo da coluna de nomes
      columns(1).align = :left

      # Estilo das linhas de conteúdo
      rows(1..-1).height = 20
      rows(1..-1).font_size = 8
    end

    render_pdf(pdf, "notas_#{@classroom.name.parameterize}.pdf")
  end

  def render_pdf(pdf, filename)
    send_data pdf.render,
              filename: filename,
              type: "application/pdf",
              disposition: "inline"
  end

  def render_pdf(pdf, filename)
    send_data pdf.render,
              filename: filename,
              type: "application/pdf",
              disposition: "inline"
  end
end
