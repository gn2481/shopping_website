class CartsController < ApplicationController
  def clean 
    current_cart.clean!
    redirect_back fallback_location: root_path, notice: '成功清除購物車'
  end
end
