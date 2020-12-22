class Order < ApplicationRecord
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :ship_name, presence: true
  validates :ship_address, presence: true

  has_many :product_lists
end
