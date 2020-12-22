class Order < ApplicationRecord
  before_create :generate_token
  validates :billing_name, presence: true
  validates :billing_address, presence: true
  validates :ship_name, presence: true
  validates :ship_address, presence: true

  belongs_to :user
  has_many :product_lists

  include AASM

  aasm do
    state :order_placed, initial: true
    state :paid
    state :shipping
    state :shipped
    state :order_cancelled
    state :good_returned

    # 未付款 -> 已付款
    event :make_payment, after_commit: :pay! do
      transitions from: :order_placed, to: :paid
    end

    # 已付款 -> 出貨中
    event :ship do
      transitions from: :paid, to: :shipping
    end

    # 出貨中 -> 已到貨
    event :deliver do
      transitions from: :shipping, to: :shipped
    end

    # 已到貨 -> 退貨
    event :return_good do
      transitions from: :shipped, to: :good_returned
    end

    # 已付款 ->
    # 未付款 -> 取消訂單
    event :cancel_order do
      transitions from: %i[order_placed paid], to: :order_cancelled
    end
  end
  def set_payment_with!(method)
    update(payment_method: method)
  end

  def pay!
    update(is_paid: true)
  end

  private

  def generate_token
    self.token = SecureRandom.uuid
  end
end
