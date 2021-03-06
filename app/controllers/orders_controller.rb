class OrdersController < ApplicationController
  
  def index
    @orders = Order.paginate :page=>params[:page], :order=>'created_at desc',
    :per_page => 10
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @orders }
    end
  end
  def create
      @order = Order.new(params[:order])
      @order.add_order_items_from_cart(current_cart)
      respond_to do |format|
        if @order.save
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          format.html { redirect_to(root_url, :notice =>
          'Thank you for your order.') }
          format.xml { render :xml => @order, :status => :created,
          :location => @order }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @order.errors,
          :status => :unprocessable_entity }
        end
      end
    end


  def new
    @cart = current_cart
    if @cart.order_items.empty?
      redirect_to root_url, :notice => "Your cart is empty"
      return
    end

    @order = Order.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @order }
    end
  end 
end