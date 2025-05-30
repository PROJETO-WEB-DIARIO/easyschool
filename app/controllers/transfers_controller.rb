class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show edit update destroy ]

  # GET /transfers or /transfers.json
  def index
    @per_page = 10 # Define quantos itens por página você quer
    @page = params[:page].to_i
    @page = 1 if @page < 1 # Garante que a página mínima seja 1

    # Inicia a query com a pré-carga de alunos
    transfers_query = Transfer.includes(:student)

    # Lógica de pesquisa e filtro
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      filter_by = params[:filter_by] # Captura a opção de filtro

      case filter_by
      when "student_name"
        transfers_query = transfers_query.joins(:student).where("students.name LIKE ?", search_term)
      when "school_destination"
        transfers_query = transfers_query.where("school_destination LIKE ?", search_term)
      else # Caso nenhum filtro seja selecionado ou um valor inválido, pesquisa em ambos
        transfers_query = transfers_query.joins(:student).where(
          "students.name LIKE ? OR school_destination LIKE ?",
          search_term,
          search_term
        )
      end
    end

    # Conta o total de resultados ANTES de aplicar limit e offset
    @total_transfers_count = transfers_query.count

    # Aplica a paginação
    @transfers = transfers_query.limit(@per_page).offset((@page - 1) * @per_page)
  end

  # GET /transfers/1 or /transfers/1.json
  def show
    # @transfer já é carregado pelo set_transfer. Vamos otimizar set_transfer
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers or /transfers.json
  def create
    @transfer = Transfer.new(transfer_params)

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to transfer_url(@transfer), notice: "Transferência criada com sucesso." }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transfers/1 or /transfers/1.json
  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to transfer_url(@transfer), notice: "Transferência atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1 or /transfers/1.json
  def destroy
    @transfer.destroy!

    respond_to do |format|
      format.html { redirect_to transfers_url, notice: "Transferência excluída com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      # Otimização: Carrega o aluno junto com a transferência para a página de detalhes
      @transfer = Transfer.includes(:student).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transfer_params
      params.require(:transfer).permit(:student_id, :school_destination, :transfer_date)
    end
end