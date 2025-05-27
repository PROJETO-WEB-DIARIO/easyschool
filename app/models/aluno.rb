class Aluno < ApplicationRecord
  validates :nome, presence: true
end
