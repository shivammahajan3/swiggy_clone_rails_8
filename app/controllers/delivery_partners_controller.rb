class DeliveryPartnersController < ApplicationController
  
  def index
    @orders = Order.accepted
  end

  def current_deliveries
    @orders = Order.shipping.where(delivery_partner: current_user)
  end

  def completed_deliveries
    @orders = Order.delivered.where(delivery_partner: current_user)
  end

  def accept_order
    order = Order.find(params[:id])

    if order.completed? || order.accepted?
      order.update(status: 'shipping', delivery_partner: current_user)

      # Notify the restaurant and the user about the delivery
      flash[:notice] = "Order is now in transit."
      redirect_to delivery_partners_current_deliveries_path
    else
      flash[:alert] = "This order cannot be accepted at this time."
      redirect_to deliveries_path
    end
  end

  def complete_order
    order = Order.find(params[:id])

    if order.status == 'shipping' && order.delivery_partner == current_user
      order.delivered!

      # Notify the user and restaurant that the order has been delivered
      flash[:notice] = "Order completed successfully."
      redirect_to delivery_partners_completed_deliveries_path
    else
      flash[:alert] = "This order cannot be marked as completed."
      redirect_to delivery_partners_current_deliveries_path
    end
  end

end
