class CartsController < ApplicationController
  before_action :authenticate_user!

  def clean 
    current_cart.clean!
    redirect_back fallback_location: root_path, notice: '成功清除購物車'
  end

  def checkout
    @order = Order.new
  end
end
