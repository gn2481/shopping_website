class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    @order = order
    @user = order.user
    @product_lists = order.product_lists

    mail(to: @user.email, subject: "[cat.com] 感謝您本次的購買，以下是您的交易明細" )
  end

  def apply_cancel(order)
    @order = order
    @user = order.user
    @product_lists = order.product_lists

    mail(to: "admin@test.com", subject: "[cat.com] #{@user.email}用戶，申請取消訂單#{@order.token}")
  end

end
