class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def add_to_cart 
    product = Product.find(params[:id])
    current_cart.add_product_to_cart(product)
    redirect_back fallback_location: root_path, notice: '成功加入購物車'
  end
end
