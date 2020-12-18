class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items

  def add_product_to_cart(product)
    ci = self.cart_items.new
    ci.product_id = product.id    
    ci.quantity = 1
    ci.save
  end

end
