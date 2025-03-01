class OrdersController < ApplicationController

  def index

  end

  def current_user_orders
    @orders = current_user.orders
  end

  def restro_orders

  end

  def product_orders

  end

end