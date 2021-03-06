class Admin::OrdersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :require_is_admin
  before_action :find_order, only: [:show, :cancel, :ship, :shipped, :return]

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @product_lists = @order.product_lists
  end
  
  def cancel
    @order.cancel_order!
    OrderMailer.notify_cancel(@order).deliver!
    redirect_back fallback_location: root_path, notice: "已取消訂單"
  end

  def ship
    @order.ship!
    OrderMailer.notify_ship(@order).deliver!
    redirect_back fallback_location: root_path, notice: "已出貨"
  end

  def shipped
    @order.deliver!
    OrderMailer.notify_shipped(@order).deliver!
    redirect_back fallback_location: root_path, notice: "已到貨"
  end

  def return
    @order.return_good!
    redirect_back fallback_location: root_path, notice: "已退貨"
  end

  private
  def find_order
    @order = Order.find(params[:id])
  end
end
