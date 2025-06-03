class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  
  belongs_to :research_group, optional: true # Um post pode ou não pertencer a um grupo
  # Ou pode ser polymorphic, mas com optional: true é mais simples para começar.
  
  validates :content, presence: true
end
