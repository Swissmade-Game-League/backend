class Payment < ApplicationRecord
  belongs_to :user
  has_one :product

  validates :user, :amount, presence: true

  after_save :paid_value_changed

  def paid_value_changed
    should_send_it = self.saved_change_to_attribute?(:paid) && self.paid == true
    if should_send_it && self.user
      product = self.get_first_unassigned_product
      product.payment = self
      if product && product.save && self.save
        RegistrationMailer.send_payment_confirmation(self.user).deliver_now
      end
    end
  end

  def gen_token
    self.token = loop do
      token = SecureRandom.hex(24)
      break token unless Payment.exists?(token: token)
    end
  end

  def get_first_unassigned_product
    return Product.where(payment: nil).first
  end

end
