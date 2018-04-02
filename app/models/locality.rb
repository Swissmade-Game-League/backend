class Locality < ApplicationRecord
  has_many :addresses, :dependent => :delete_all
  belongs_to :state

  validates :state, presence: true

end
