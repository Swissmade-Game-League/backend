class Product < ApplicationRecord
  belongs_to :payment, optional: true
end
