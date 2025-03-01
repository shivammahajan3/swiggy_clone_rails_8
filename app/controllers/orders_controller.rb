class OrdersController < ApplicationController

  def current_user_orders
    @orders = current_user.orders
  end

end