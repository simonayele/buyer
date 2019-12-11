class ApplicationController < ActionController::Base
     protect_from_forgery with: :exception 
 
  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end


  private
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end


end
