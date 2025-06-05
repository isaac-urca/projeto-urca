class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # Validação para garantir que um usuário não possa seguir outro mais de uma vez
  validates :follower_id, uniqueness: { scope: :followed_id, message: "já está seguindo este usuário." }
end
