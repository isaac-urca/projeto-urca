class ResearchGroup < ApplicationRecord
  has_one_attached :avatar

  # Enum para visibilidade
  enum visibility: { public_group: 0, private_group: 1, secret_group: 2 }

  # Associações
  belongs_to :admin, class_name: 'User'
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships # Membros do grupo

  # Um grupo pode ter posts específicos
  has_many :posts, dependent: :destroy # Assumindo que um Post pode pertencer a um ResearchGroup

  # Validações
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 1000 }, allow_blank: true

  after_create :set_membership_for_admin
  
  private
  def set_membership_for_admin
    # Cria uma associação de membro para o administrador do grupo
    self.memberships.create(user: self.admin, role: :moderator, status: :active) 
  end
end
