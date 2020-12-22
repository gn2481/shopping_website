class AddNullFalseToOrderAndProductList < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:orders, :user_id, false)
    change_column_null(:product_lists, :order_id, false)
  end
end
