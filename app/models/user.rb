class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :user_profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :research_groups, through: :memberships # Grupos dos quais o usuário é membro

  has_many :administered_research_groups, class_name: 'ResearchGroup', foreign_key: 'admin_id', dependent: :nullify

  # Usuários que este usuário está seguindo
  has_many :active_follows, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_follows, source: :followed

  # Usuários que estão seguindo este usuário
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  validate :cannot_follow_self
  after_create :create_user_profile

  def following?(other_user)
    following.include?(other_user)
  end

  private
  
  def create_user_profile
    build_user_profile(name: email.split('@').first, bio: "Olá! Sou um novo usuário.")
    user_profile.save
  end

  def cannot_follow_self
    if following.include?(self)
      errors.add(:base, "Você não pode seguir a si mesmo.")
    end
  end
end
