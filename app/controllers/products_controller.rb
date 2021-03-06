class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @product = Product.new
  end

  def index
    @products = Product.paginate(page: params[:page], per_page:6)
    @cart = current_cart
  end

  def destroy
    @product = Product.find_by_id(params[:id])
    return render_not_found if @product.blank?
    return render_not_found(:forbidden) if @product.user != current_user
    @product.destroy
    redirect_to root_path
  end


  def update
    @product = Product.find_by_id(params[:id])
    return render_not_found if @product.blank?
    return render_not_found(:forbidden) if @product.user != current_user
    
    @product.update_attributes(product_params)
    
    if @product.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find_by_id(params[:id])
    return render_not_found if @product.blank?
    return render_not_found(:forbidden) if @product.user != current_user
  end

  def show
    @product = Product.find_by_id(params[:id])
    return render_not_found if @product.blank?
    
  end

  def create
    @product = current_user.products.create(product_params)
    if @product.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def display_cart
    @cart = find_cart
    @items = @cart.items
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @cart.add_product(product)
    redirect_to(:action => 'display_cart')
  end


private

  def product_params
    params.require(:product).permit(:name, :price, :description, :picture)
  end

end

