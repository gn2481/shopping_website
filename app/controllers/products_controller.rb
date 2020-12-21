class ProductsController < ApplicationController
  before_action :find_product,only:[:show, :add_to_cart]
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def add_to_cart 
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      redirect_back fallback_location: root_path, notice: '成功加入購物車'
    else
      redirect_back fallback_location: root_path, alert: '你已擁有此商品，若要更改數量，請至購物車頁面。'
    end
  end

  private
  def find_product
    @product = Product.find(params[:id])
  end
end
