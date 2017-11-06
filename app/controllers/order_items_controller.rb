class OrderItemsController < ApplicationController
  def create
    if @order_item = @current_order.order_items.where(product_id: order_item_params["product_id"]).first
      @order_item.quantity += order_item_params["quantity"].to_i
      @order_item.save
    else
      @order_item = @current_order.order_items.new(order_item_params)
    end
    @current_order.user = @current_user unless @current_user.id.nil?
    @current_order.save
    session[:order_id] = @current_order.id
  end

  def update
    @order_item = @current_order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @current_order.user = @current_user unless @current_user.id.nil?
    @current_order.save
    @order_items = @current_order.order_items.order(:id)
  end

  def destroy
    @order_item = @current_order.order_items.find(params[:id])
    @order_item.destroy
    @current_order.user = @current_user unless @current_user.id.nil?
    @current_order.save
    @order_items = @current_order.order_items.order(:id)
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
