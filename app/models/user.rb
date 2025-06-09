class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one_attached :avatar


  # Normaliza o email_address
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  # Valida o campo de role
  validates :role, inclusion: { in: [ "gestor", "secretaria" ], message: "%{value} não é um cargo válido" }, allow_nil: true

  # Valida a presença de senha e a confirmação de senha na criação
  validates :password, presence: true, confirmation: true, on: :create
  validates :password, confirmation: true, allow_nil: true, on: :update

  # Método de conveniência para verificar se o usuário é gestor
  def gestor?
    role == "gestor"
  end

  # Método de conveniência para verificar se o usuário é da secretaria
  def secretaria?
    role == "secretaria"
  end
end
