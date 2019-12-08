class OrderItemsController < ApplicationController
  before_action :current_cart

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
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product.id)
    respond_to do |format|
      if @order_item.save
        format.html { redirect_to(@order_item.cart,
          :notice => 'Line item was successfully created.') }
        format.xml { render :xml => @order_item,
          :status => :created, :location => @order_item }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @order_item.errors,
          :status => :unprocessable_entity }
      end
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



