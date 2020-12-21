class CartItemsController < ApplicationController
  def destroy
    @item = CartItem.find(params[:id])
    @item.destroy
    redirect_back fallback_location: root_path, notice: '成功刪除商品'
  end

end
