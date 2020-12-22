class OrdersController < ApplicationController
  def create
    @order = current_user.orders.new(order_params)
    if @order.save
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
