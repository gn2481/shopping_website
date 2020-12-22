class AddForeignKeyToProductList < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :product_lists, :orders
  end
end
