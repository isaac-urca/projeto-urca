class UserProfile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  # Enum para roles (ajuste os valores conforme sua necessidade)
  enum role: { student: 0, professor: 1, admin: 2 }

  # Validações (já existentes ou aprimoradas)
  validates :name, presence: true, length: { maximum: 100 }
  validates :bio, length: { maximum: 500 }, allow_blank: true
  validates :lattes_link, format: URI::regexp(%w[http https]), allow_blank: true
end
