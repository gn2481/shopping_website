class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    mail(to: @user.email, subject: "[cat.com] 感謝您本次的購買，以下是您的交易明細" )
  end

  def apply_cancel(order)
    find_order_user_product_list(order)
    mail(to: "admin@test.com", subject: "[cat.com] #{@user.email}用戶，申請取消訂單#{@order.token}")
  end

  def notify_cancel(order)
    find_order_user_product_list(order)
    mail(to: @user.email, subject: "[cat.com] 您的訂單#{@order.token}已取消！")
  end

  def notify_ship(order)
    find_order_user_product_list(order)
    mail(to: @user.email, subject: "[cat.com] 感謝您本次的購買，您的訂單#{@order.token}已出貨！")
  end

  def notify_shipped(order)
    find_order_user_product_list(order)
    mail(to: "admin@test.com", subject: "[cat.com] #{@user.email}用戶，您的訂單#{@order.token}已到貨！")
  end

  def find_order_user_product_list(order)
    @order = order
    @user = order.user
  end
end
