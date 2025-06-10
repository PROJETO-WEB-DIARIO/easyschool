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
    when "pauta"
      generate_signature_sheet
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

    # Converte o nome do mês (em português) para um número de 1 a 12
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

    # Calcula o número de dias no mês. Se o mês for inválido, assume 31 dias.
    if month_number
      days_in_month = Time.days_in_month(month_number, year)
    else
      days_in_month = 31 # Valor padrão
    end

    # --- FIM DA LÓGICA DE DIAS DINÂMICOS ---

    # Define o caminho da imagem do cabeçalho para layout paisagem (cabecalho.png)
    landscape_header_path = Rails.root.join("app", "assets", "images", "cabecalho.png")

    pdf = Prawn::Document.new(page_size: "A4", page_layout: :landscape, margin: [ 40, 40, 40, 40 ])

    # Adiciona o cabeçalho para o layout paisagem
    if File.exist?(landscape_header_path)
      # Ajuste as coordenadas 'at' [x, y] e 'width'/'height' conforme necessário para sua imagem específica do cabeçalho.
      # A coordenada 'at' [x, y] é relativa ao canto superior esquerdo da página.
      # Provavelmente você desejará colocá-la perto do topo da página.
      # A largura foi definida para preencher a largura dos limites do PDF.
      pdf.image landscape_header_path, at: [ pdf.bounds.left, pdf.bounds.top + 20 ], width: pdf.bounds.width # Ajuste a largura conforme necessário
    end

    # Move o cursor para baixo para iniciar o conteúdo abaixo do cabeçalho.
    # Ajuste este valor com base na altura da sua imagem de cabeçalho.
    pdf.move_down 70

    pdf.text "Folha de Frequência #{year}", size: 18, style: :bold, align: :center
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

    header = [ "Nº", "NOME DO ALUNO" ] + (1..days_in_month).to_a.map(&:to_s)
    table_data = [ header ]

    @students.each_with_index do |student, i|
      student_row = [ "%02d" % (i + 1), student.name.upcase ]
      table_data << (student_row + Array.new(days_in_month, ""))
    end

    name_column_width = 180
    day_column_width = 17.5
    column_widths = [ 30, name_column_width ] + ([ day_column_width ] * days_in_month)

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

    render_pdf(pdf, "frequencia_#{@classroom.name.parameterize}.pdf")
  end

  def generate_grades_sheet
    bimestre = params[:bimestre].presence || "______________"

    # Define o caminho da imagem do cabeçalho para layout paisagem (cabecalho.png)
    landscape_header_path = Rails.root.join("app", "assets", "images", "cabecalho.png")

    pdf = Prawn::Document.new(page_size: "A4", page_layout: :landscape, margin: [ 40, 40, 40, 40 ])

    # Adiciona o cabeçalho para o layout paisagem
    if File.exist?(landscape_header_path)
      pdf.image landscape_header_path, at: [ pdf.bounds.left, pdf.bounds.top + 20 ], width: pdf.bounds.width # Ajuste a largura conforme necessário
    end

    # Move o cursor para baixo para iniciar o conteúdo abaixo do cabeçalho.
    # Ajuste este valor com base na altura da sua imagem de cabeçalho.
    pdf.move_down 70

    pdf.text "Folha de Notas 2025", size: 18, style: :bold, align: :center
    pdf.move_down 20
    info_data = [
      [ "Professor(a): #{@professor}", "Bimestre: #{bimestre}" ],
      [ "Turma: #{@classroom.name}",  "Disciplina: #{@discipline}" ]
    ]
    pdf.table(info_data, width: pdf.bounds.width) do
      cells.border_width = 0; cells.padding = [ 2, 0, 2, 0 ]
      column(0).width = width / 2; column(1).width = width / 2
    end
    pdf.move_down(20)

    header = [ "Nº", "NOME DO ALUNO", "1º RP", "2º RP", "3º RP", "4º RP", "5º RP", "1ª NOTA", "2ª NOTA", "MB" ]
    table_data = [ header ]

    @students.each_with_index do |student, i|
      table_data << ([ "%02d" % (i + 1), student.name.upcase ] + Array.new(8, ""))
    end

    grade_column_width = 60
    column_widths = [ 30, 250 ] + ([ grade_column_width ] * 8)

    pdf.table(table_data, header: true, column_widths: column_widths) do
      cells.padding = [ 4, 4, 4, 4 ]
      cells.align = :center

      row(0).font_style = :bold
      row(0).background_color = "eeeeee"
      row(0).font_size = 9

      columns(1).align = :left

      rows(1..-1).height = 20
      rows(1..-1).font_size = 8
    end

    render_pdf(pdf, "notas_#{@classroom.name.parameterize}.pdf")
  end

  def generate_signature_sheet
    descricao = params[:descricao].presence || "PAUTA DE ASSINATURA"
    # Define o caminho da imagem do cabeçalho para layout retrato (cabecalho2.png)
    portrait_header_path = Rails.root.join("app", "assets", "images", "cabecalho2.png")

    pdf = Prawn::Document.new(page_size: "A4", margin: [ 40, 40, 40, 40 ])

    # Adiciona o cabeçalho para o layout retrato
    if File.exist?(portrait_header_path)
      # Ajuste as coordenadas 'at' [x, y] e 'width'/'height' conforme necessário para sua imagem específica do cabeçalho.
      pdf.image portrait_header_path, at: [ pdf.bounds.left, pdf.bounds.top + 20 ], width: pdf.bounds.width # Ajuste a largura conforme necessário
    end

    # Move o cursor para baixo para iniciar o conteúdo abaixo do cabeçalho.
    # Ajuste este valor com base na altura da sua imagem de cabeçalho.
    pdf.move_down 70

    pdf.text descricao.upcase, size: 14, style: :bold, align: :center
    pdf.move_down 5
    pdf.text "#{@classroom.name.upcase}", size: 12, style: :bold, align: :center
    pdf.move_down 20

    pdf.text "NOME DO ALUNO", size: 10, style: :bold
    pdf.move_down 5

    table_data = [ [ "Nº", "Nome do Aluno", "Assinatura" ] ]
    @students.each_with_index do |student, i|
      table_data << [ "%02d" % (i + 1), student.name, "" ]
    end

    pdf.table(table_data, header: true, width: pdf.bounds.width) do
      row(0).font_style = :bold
      row(0).background_color = "eeeeee"
      columns(0).width = 30
      columns(1).width = 300
      columns(2).width = pdf.bounds.width - 330
      cells.padding = 6
      cells.size = 10
    end

    render_pdf(pdf, "pauta_#{@classroom.name.parameterize}.pdf")
  end

  def render_pdf(pdf, filename)
    send_data pdf.render,
              filename: filename,
              type: "application/pdf",
              disposition: "inline"
  end
end
