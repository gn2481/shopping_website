class CartItemsController < ApplicationController
  before_action :authenticate_user!
  
  def update
    @item = CartItem.find_by(product_id: params[:id])
      if @item.product.quantity >= item_params[:quantity].to_i 
        @item.update(item_params)
        redirect_to carts_path, notice: '成功更改數量'
      else
        redirect_to carts_path, alert: '抱歉，目前商品庫存不足'
      end
  end
  
  
  
  def destroy
    @item = CartItem.find(params[:id])
    @item.destroy
    redirect_back fallback_location: root_path, notice: '成功刪除商品'
  end
  
  private
  def item_params
    params.require(:cart_item).permit(:quantity)
  end

end
