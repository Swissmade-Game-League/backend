class Gender < ApplicationRecord

  # Validations
  validates :name, uniqueness: true
  # -----

  # Relations
  has_many :users
  # -----

end
