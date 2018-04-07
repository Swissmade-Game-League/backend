class Country < ApplicationRecord
  has_many :states, :dependent => :delete_all
end
