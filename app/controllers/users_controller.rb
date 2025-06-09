class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
    if params[:search].present?
      @users = @users.where("email_address LIKE ?", "%#{params[:search]}%")
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "Usuário criado com sucesso."
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "Usuário atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: "Usuário excluído com sucesso."
  end

  def update_avatar
  @user = User.find(params[:id])
  if params[:user][:avatar]
    @user.avatar.attach(params[:user][:avatar])
    redirect_back fallback_location: dashboard_path, notice: "Imagem atualizada com sucesso!"
  else
    redirect_back fallback_location: dashboard_path, alert: "Nenhuma imagem selecionada."
  end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :role, :password, :password_confirmation)
  end
end
