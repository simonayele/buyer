class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy
  
 
  def add_product(product_id)
    current_item = order_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = order_items.build(product_id: product_id)
    end
    current_item
  end
 def sub_total
    product.price * quantity
  end




  def total_price
    order_items.to_a.sum { |item| item.total_price }
  end

end
