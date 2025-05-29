class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  # Normaliza o email_address
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Adiciona a validação de role
  validates :role, inclusion: { in: [ "gestor", "secretaria" ], message: "%{value} não é um cargo válido" }, allow_nil: true

  # Método de conveniência para verificar se o usuário é gestor
  def gestor?
    role == "gestor"
  end

  # Método de conveniência para verificar se o usuário é da secretaria
  def secretaria?
    role == "secretaria"
  end
end
