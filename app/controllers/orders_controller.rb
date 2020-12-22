class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end
  
  def create
    @order = current_user.orders.new(order_params)
    @order.total = current_cart.total_price 
    if @order.save
      current_cart.cart_items.each do |item|
        product_list = @order.product_lists.new
        product_list.product_name = item.product.title
        product_list.product_price = item.product.price
        product_list.quantity = item.quantity
        product_list.save
      end
      redirect_to @order, notice: "訂單建立成功"
    else
      render 'carts/checkout', alert: "請再試一次"
    end
  end
  
  private
  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :ship_name, :ship_address)
  end
end
