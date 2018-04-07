class Payment < ApplicationRecord
  belongs_to :user
  has_one :product

  validates :user, :amount, presence: true
  validate :assign_product
  validate :check_amount

  before_create :gen_token
  before_save :assign_product
  after_save :send_mail

  def assign_product
    should_assign_product = self.paid == true && !product
    if should_assign_product && self.user
      product = self.get_first_unassigned_product
      product.payment = self
    end
  end

  def send_mail
    should_send_it = self.saved_change_to_attribute?(:paid) && self.paid == true
    if should_send_it && self.valid? && self.save
      RegistrationMailer.send_payment_confirmation(self.user).deliver_now
    end
  end

  def check_amount
    if product && amount < product.price
      errors.add(:base, "Nice try dude, you need to pay "+product.price.to_s+" CHF not "+amount.to_s+". You little hacker 😈")
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
