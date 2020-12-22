class Order < ApplicationRecord
  before_create :generate_token
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :ship_name, presence: true
  validates :ship_address, presence: true

  has_many :product_lists
  def set_payment_with!(method)
    self.update(payment_method: method)
  end

  def pay!
    self.update(is_paid: true)
  end


  private
  def generate_token
    self.token = SecureRandom.uuid
  end

end
