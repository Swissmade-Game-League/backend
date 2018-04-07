class User < ApplicationRecord
  # Validations
  validates :firstname, :lastname, :mail, :birthdate, :password, :password_confirmation, :salt, :nickname, presence: true
  validates :gender, :address, presence: true
  validates :password, confirmation: true
  validates :password, :length => { minimum: 7 }
  validates :mail, uniqueness: true
  validate :check_count_by_state
  validate :is_addr_valid
  # -----

  # Hooks
  before_create :gen_token_and_salt
  before_create :change_password
  before_save :set_lowercase
  # -----

  # Relations
  belongs_to :gender
  belongs_to :address
  has_many :payments
  # -----

  def set_lowercase
    self.firstname = self.firstname.downcase
    self.lastname = self.lastname.downcase
    self.mail = self.mail.downcase
  end

  def gen_token_and_salt
    self.gen_token
    self.gen_salt
  end

  def gen_token
    self.token = loop do
      token = SecureRandom.hex(12)
      break token unless User.exists?(token: token)
    end
  end

  def gen_salt
    self.salt = loop do
      salt = SecureRandom.hex(12)
      break salt unless User.exists?(salt: salt)
    end
  end

  def encrypt_password(password)
    return Digest::SHA2.new(512).hexdigest(password+self.salt)
  end

  def change_password(password=self.password)
    passwd=self.encrypt_password(password)
    self.password = passwd
    self.password_confirmation = passwd
  end

  def authenticate(password)
    if encrypt_password(password) == self.password
      return true
    end
    return false
  end

  def check_count_by_state
    state = self.address.locality.state
    if self.address.locality.state.country == Country.find_by(name: "Switzerland")
      # Swiss players
      user_count = User.includes(address: {locality: :state}).where(states: {id: state.id}).count
      if user_count >= Rails.application.secrets.max_player_by_state
        errors.add(:base, "Reached the max number of players located in your state")
      end
    else
      # Foreign players
      user_count = User.includes(address: {locality: {state: :country}}).where.not(countries: {name: "Switzerland"})
      if user_count >= Rails.application.secrets.max_player_by_state
        errors.add(:base, "Reached the max number of foreign players located out of Switzerland")
      end
    end
  end

  def is_addr_valid
    full_addr = self.address.to_string
    api_result = JT::Rails::Address.search(full_addr, Rails.application.secrets.google_maps_api_key)
    if !api_result
      errors.add(:base, "Invalid user's address")
    end
  end

end
