class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  before_save :update_subtotal
  
  def add_order_items_from_cart(cart)
    cart.order_items.each do |item|
      item.cart_id = nil
      order_items << item
    end
  end
  

 private
 def update_subtotal
    self[:subtotal] = subtotal
  end

 end

