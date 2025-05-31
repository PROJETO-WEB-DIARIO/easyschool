class UserPolicy < ApplicationPolicy
  def index?
    user.gestor?
  end

  def edit?
    user.gestor?
  end
end
