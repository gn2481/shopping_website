class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only:[:show, :pay_with_atm, :pay_with_credit_card, :apply_to_cancel]
  def show
    # find_by_欄位名稱
    @product_lists = @order.product_lists
  end
  
  def create
    @order = current_user.orders.new(order_params)
    @order.total = current_cart.total_price 
    if @order.save
      current_cart.cart_items.each do |item|
        product_list = @order.product_lists.new(
        product_name: item.product.title,
        product_price: item.product.price,
        quantity: item.quantity)
        product_list.save
      end
      current_cart.clean!
      OrderMailer.notify_order_placed(@order).deliver!

      redirect_to order_path(@order.token) , notice: "訂單建立成功"
    else
      render 'carts/checkout', alert: "請再試一次"
    end
  end

  def pay_with_credit_card
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("credit_card")
    @order.make_payment! # aasm_state: order_placed -> paid
    redirect_to order_path(@order.token) , notice: "信用卡付款成功"
  end

  def pay_with_atm
    @order = Order.find_by_token(params[:id])
    @order.set_payment_with!("atm")
    @order.make_payment! # aasm_state: order_placed -> paid
    redirect_to order_path(@order.token) , notice: "atm轉帳成功"
  end

  def apply_to_cancel
    OrderMailer.apply_cancel(@order).deliver!
    redirect_to order_path(@order.token), notice: "已提交申請"
  end
  
  private
  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :ship_name, :ship_address)
  end
  def find_order
    @order = Order.find_by_token(params[:id])
  end
end
