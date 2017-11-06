class CartsController < ApplicationController
  def show
    @order_items = @current_order.order_items.order(:id)
  end

  def buy
    @current_order.update(status: :shipped)
    new_order = @current_user.orders.new
    session[:order_id] = new_order.id
    redirect_to root_url, flash: { info: 'Your order has been delivered' }
  end
end
