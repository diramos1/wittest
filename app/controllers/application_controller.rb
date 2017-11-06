class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_order
  before_action :current_user

  helper_method :current_order

  def current_order
    @current_order = 
      if !session[:order_id].nil?
        order = Order.find(session[:order_id])
        if !order.valid_ttl?
          order.update(status: :cancelled)
          Order.new(total: 0)
        else
          order
        end
      else
        Order.new(total: 0)
      end
  end

  def current_user
    @current_user = 
      if !session[:user_id].nil?
        User.find(session[:user_id])
      else
        User.new
      end
  end

  private


end
