class OrdersController < ApplicationController

  def current_user_orders
    @orders = current_user.orders.order(created_at: :desc)
  end

  def update_status
    # debugger
    order = Order.find(params[:id])
    order.completed!
    flash[:notice] = "Order status has updated!"
    redirect_to recent_orders_path(params[:restro_id])
  end

end