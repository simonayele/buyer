class OrdersController < ApplicationController
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