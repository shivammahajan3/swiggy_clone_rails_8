class OrdersController < ApplicationController

  def current_user_orders
    @orders = current_user.orders.order(created_at: :desc)
  end

end