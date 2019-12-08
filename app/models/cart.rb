class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy
  
  def add_product(product_id)
    current_item = order_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = order_items.build(:product_id => product_id)
    end
      current_item
  end

  def sub_total
    sum = 0
    self.order_items.each do |order_item|
      sum+= order_item.total_price
    end
    return sum
  end
end
