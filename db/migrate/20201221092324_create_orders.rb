class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :total, default: 0
      t.references :user
      t.string :billing_name
      t.string :billing_address
      t.string :ship_name
      t.string :ship_address

      t.timestamps
    end
  end
end
