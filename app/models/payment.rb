class Payment < ApplicationRecord
  belongs_to :user

  validates :user, :amount, presence: true

  after_save :paid_value_changed

  def paid_value_changed
    should_send_it = self.paid_changed? && self.paid == true
    if should_send_it && self.user
      RegistrationMailer.send_payment_confirmation(self.user).deliver_now
    end
  end

  def gen_token
    self.token = loop do
      token = SecureRandom.hex(24)
      break token unless Payment.exists?(token: token)
    end
  end

end
