class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  layout "login"

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      session[:user_id] = user.id  # Armazena o ID do usuário na sessão
      redirect_to after_authentication_url  # Redireciona após o login
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    session[:user_id] = nil  # Limpa o ID do usuário da sessão ao fazer logout
    redirect_to new_session_path
  end
end
