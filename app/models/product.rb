class Product < ApplicationRecord
  
  validates :name, presence: true
  validates :picture, presence: true
  mount_uploader :picture, PictureUploader
  belongs_to :user
  has_many :order_items
  has_many :carts, through: :order_items

  

end
