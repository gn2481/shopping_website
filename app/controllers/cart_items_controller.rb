class CartItemsController < ApplicationController
  
  def update
    @item = CartItem.find_by(product_id: params[:id])
      if @item.update(item_params)
        redirect_back fallback_location: root_path, notice: '成功更改數量'
      else
        redirect_back fallback_location: root_path, alert: '請再試一次'
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
