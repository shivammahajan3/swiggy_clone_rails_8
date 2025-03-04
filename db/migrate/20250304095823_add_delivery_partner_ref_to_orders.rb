class AddDeliveryPartnerRefToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :delivery_partner
  end
end
