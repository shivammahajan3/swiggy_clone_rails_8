class ProductsController < ApplicationController

  def new
    @restro = Restro.find(params[:restro_id])
    @product = @restro.products.new 
  end

  def create
    restro = Restro.find(params[:restro_id])
    @product = restro.products.new(product_params)
    if @product.save
      flash[:notice] = "Product has been added to the #{restro.name}"
    else
      flash[:alert] = "Something went wrong!"
    end
    redirect_to restro
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
    
    cart_item = session[:cart].find { |item| item['product_id'].to_i == product.id.to_i }

    if cart_item
      cart_item['quantity'] += 1
    else
      session[:cart] << { product_id: product.id, quantity: 1 }
    end
    flash[:notice] = "#{product.name} has been added to your cart."
    redirect_to restro_path(product.restro_id)
  end

  private

  def product_params
    params.expect(product: [:name, :price, :prod_profile])
  end
end
