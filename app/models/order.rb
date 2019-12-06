class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  before_save :update_subtotal
  
  

 private
 def update_subtotal
    self[:subtotal] = subtotal
  end

 end

