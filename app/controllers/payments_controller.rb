class PaymentsController < ApplicationController
  before_action :amount_to_be_charged, :set_description

  def new
    session[:total_amount] = params[:total_amount]
  end

  def create
    amount_in_paise = (@amount * 100).to_i

    customer = StripeTool.create_customer(email: params[:stripeEmail], stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, amount: amount_in_paise, description: @description )

    if charge.status == 'succeeded'
      create_order_for_cart
      
      session[:cart] = []
      flash[:notice] = "Payment successful! Your Order has been Accepted."
      redirect_to thanks_path
    else
      flash[:alert] = "Payment failed. Please try again."
      render :new, status: 422
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end

  def thanks

  end

  private

  def amount_to_be_charged
    @amount = session[:total_amount].to_f
  end
  
  def set_description
    @description = "Order Payment"
  end

  def create_order_for_cart
    # debugger
    product_id = session[:cart].first['product_id']
    restro = Product.find(product_id).restro
    order = Order.create(
      user: current_user,
      restro: restro,
      total_price: @amount,
      order_time: Time.current,
      status: 1
    )

    session[:cart].each do |cart_item|
      product = Product.find(cart_item['product_id'])
      OrderProduct.create(
        order: order,
        product: product,
        quantity: cart_item['quantity']
      )
    end
  end

end