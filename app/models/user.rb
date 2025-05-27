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

  after_create :create_user_profile

  private
  def create_user_profile
    build_user_profile(name: email.split('@').first, bio: "Olá! Sou um novo usuário.")
    user_profile.save
  end
end
