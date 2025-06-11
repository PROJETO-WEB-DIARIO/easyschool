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

  before_destroy :prevent_last_admin_deletion
  before_update  :prevent_last_admin_role_change


  # Método de conveniência para verificar se o usuário é gestor
  def gestor?
    role == "gestor"
  end

  # Método de conveniência para verificar se o usuário é da secretaria
  def secretaria?
    role == "secretaria"
  end

  def prevent_last_admin_deletion
    # Verifica se a role do usuário é 'admin'
    if self.role == "gestor"
      # Conta quantos usuários têm a role 'admin'
      admin_count = User.where(role: "gestor").count

      # Se for menor ou igual a 1, impede a exclusão
      if admin_count <= 1
        errors.add(:base, "Não é possível excluir o último administrador do sistema.")
        throw(:abort)
      end
    end
  end

  def prevent_last_admin_role_change
    # Verifica se o campo 'role' está sendo modificado nesta atualização.
    # 'will_save_change_to_attribute?(:role)' é a forma moderna e segura de fazer isso.
    return unless will_save_change_to_attribute?(:role)

    # 'role_was' nos dá o valor da role ANTES da alteração.
    if self.role_was == "gestor"
      # Se o usuário era um gestor, contamos quantos gestores existem.
      # Usamos 'count' aqui porque a alteração ainda não foi salva, então a contagem ainda está correta.
      if User.where(role: "gestor").count <= 1
        # Adiciona o erro diretamente ao campo 'role', o que é melhor para formulários.
        errors.add(:role, "não pode ser alterada. Este é o último gestor do sistema.")
        # Interrompe a atualização
        throw(:abort)
      end
    end
  end
end
