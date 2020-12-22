class Order < ApplicationRecord
  before_create :generate_token
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :ship_name, presence: true
  validates :ship_address, presence: true

  has_many :product_lists

  private
  def generate_token
    self.token = SecureRandom.uuid
  end

end
