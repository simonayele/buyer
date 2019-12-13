class OrderItemsController < ApplicationController
  include CurrentCart
  before_action :current_cart, only: [:create, :destroy]
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
      product = Product.find(params[:product_id])
      @order_item = @cart.add_product(product.id)
      
      respond_to do |format|
        if @order_item.save
          format.html { redirect_to @order_item.cart }
          format.json { render action: 'show',
          status: :created, location: @order_item }
        else
          format.html { render action: 'new' }
          format.json { render json: @order_item.errors,
          status: :unprocessable_entity }
        end
      end
    end

  
  def update
    @order_item = OrderItem.find(params[:id])

    respond_to do |format|
      if @order_item.update_attributes(params[:order_item])
        format.html { redirect_to @order_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def destroy
    @order_item.destroy
    redirect_to cart_path
  end

  private

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end
   
    def order_item_params
      params.require(:order_item).permit(:product_id, :quantity, :cart_id)
    end
end



