class ProductsController < ApplicationController

  before_action :set_restro_user, only: [ :new, :create ]
  before_action :require_restro_user, only: [ :new, :create ]
  before_action :require_same_restro_user, only: [ :new, :create ]

  def new
    @product = @restro.products.new 
  end

  def create
    @product = @restro.products.new(product_params)
    if @product.save
      flash[:notice] = "Product has been added to the #{@restro.name}"
    else
      flash[:alert] = "Something went wrong!"
    end
    redirect_to @restro
  end

  def cart
    @cart_items = session[:cart] || []
    @products_in_cart = Product.where(id: @cart_items.map { |item| item['product_id'] })
    
    @total_amount = @products_in_cart.sum do |product|
      quantity = @cart_items.find { |item| item['product_id'].to_i == product.id }['quantity']
      product.price * quantity
    end
  end

  def add_to_cart
    # debugger
    product = Product.find(params[:id])
    session[:cart] ||= []
    
    product_restro_id = product.restro_id

    cart_restros = session[:cart].map{ |item| Product.find(item['product_id']).restro_id }

    if cart_restros.uniq.length > 1 || (cart_restros.any? && cart_restros.first != product_restro_id)
      flash[:alert] = "You can only order from one restaurant at a time."
      redirect_to cart_path
      return
    end

    cart_item = session[:cart].find { |item| item['product_id'].to_i == product.id.to_i }

    if cart_item
      cart_item['quantity'] += 1
    else
      session[:cart] << { product_id: product.id, quantity: 1 }
    end
    flash[:notice] = "#{product.name} has been added to your cart."
    redirect_to restro_path(product.restro_id)
  end

  def remove_from_cart
    # debugger
    product_id = params[:id]
    session[:cart].delete(session[:cart].find{ |item| item['product_id'] == product_id.to_i })
    flash[:notice] = "Item Remove From Cart"
    redirect_to cart_path
  end

  private

  def product_params
    params.expect(product: [:name, :price, :prod_profile])
  end

  def set_restro_user
    @restro = Restro.find(params[:restro_id])
  end

  def require_restro_user
    unless current_user.restro_user?
      flash[:alert] = "You can't access this!"
      redirect_to restros_path
    end
  end

  def require_same_restro_user
    unless current_user == @restro.user
      flash[:alert] = "You can't add menus to other's restaurents!"
      redirect_to restros_path
    end
  end

end
