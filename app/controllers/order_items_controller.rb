class OrderItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create]
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]


  def index
    @order_items = OrderItem.all
  end

  def show

  end

  def new
    @order_item = OrderItem.new
  end

  def edit
  end

 def create
    @cart = current_cart
    @product = Product.find(params[:product_id])
    @order_item = @cart.add_product(@product)

    if @order_item.save
        redirect_to root_url, notice:'Product added to Cart'
    else
        render :new
    end
  end
  

  def destroy
    current_cart.remove_item(id: params[:id])
    redirect_to cart_path
  end

  private
    
    def order_item_params
      params.require(:order_item).permit(:product_id, :quantity, :cart_id)
    end
end



