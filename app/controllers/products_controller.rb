class ProductsController < ApplicationController
  def index
    @products = Product.all
    @order_item = OrderItem.new
  end
end
