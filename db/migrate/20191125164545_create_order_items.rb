class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :quantity, default: 1
      t.integer :product_id
      t.integer :cart_id

      t.timestamps
    end
    add_index :order_items, :product_id
    add_index :order_items, :cart_id
  end
end
