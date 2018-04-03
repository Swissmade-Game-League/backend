class Payment < ApplicationRecord
  belongs_to :user

  validates :user, :amount, presence: true

  def gen_token
    self.token = loop do
      token = SecureRandom.hex(24)
      break token unless Payment.exists?(token: token)
    end
  end

end
