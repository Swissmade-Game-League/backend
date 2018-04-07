class Gender < ApplicationRecord

  # Validations
  validates :name, uniqueness: true
  # -----

  # Relations
  has_many :users
  # -----

  def as_json(options={})
    self.name = self.name.capitalize
    super(options)
  end
end
