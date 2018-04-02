class State < ApplicationRecord
  has_many :localities, :dependent => :delete_all
  belongs_to :country

  validates :country, presence: true

end
