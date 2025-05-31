class ApplicationController < ActionController::Base
  include Authentication
  include Pagination
  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :require_authentication
  before_action :set_current_user

  helper_method :current_user

  # Captura erros de autorização do Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]  # Busca o usuário pela sessão
  end

  def current_user
    @current_user
  end

  def user_not_authorized
    flash[:alert] = "Você não tem permissão para acessar essa página."
    redirect_to(request.referrer || root_path)
  end
end
