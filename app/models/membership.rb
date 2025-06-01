class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :research_group

  # Enum para a função do membro dentro do grupo
  enum role: { member: 0, moderator: 1 }

  # Enum para o status da adesão (para grupos privados)
  enum status: { active: 0, pending: 1, rejected: 2 }

  # Validações para garantir que um usuário não entre no mesmo grupo mais de uma vez
  validates :user_id, uniqueness: { scope: :research_group_id, message: "já é membro deste grupo." }

  # Callback para definir o role do criador do grupo como 'moderator' e 'active'
  # (Opcional, pode ser feito no controller de criação do grupo também)
#  after_create :set_creator_as_moderator_and_active, if: -> { user == research_group.admin }

  # private

  # def set_creator_as_moderator_and_active
  #   self.update(role: :moderator, status: :active)
  # end
end
