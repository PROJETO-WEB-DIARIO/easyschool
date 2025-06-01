class ApplicationController < ActionController::Base
  include Authentication
  include Pagination
  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_current_user
  before_action :require_authentication

  helper_method :current_user

  # Captura erros de autorização do Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def set_current_user
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session.delete(:user_id) unless @current_user
    end
  end

  def current_user
    @current_user
  end

  def user_not_authorized
    flash[:alert] = "Você não tem permissão para acessar essa página."
    redirect_to(request.referrer || root_path)
  end

  def after_authentication_url
    dashboard_path
  end

  def require_authentication
    unless current_user
      respond_to do |format|
        format.html { redirect_to new_session_path, alert: "Você precisa estar logado." }
        format.turbo_stream { redirect_to new_session_path, status: :see_other }
      end
    end
  end
end
