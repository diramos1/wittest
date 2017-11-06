class AuthenticationHelper
    attr_reader :session
    def initialize(session)
        @session = session
    end

    def authenticate(user)
        @session[:user_id] = user.id
        load_user_order(user)
    end

    def load_user_order(user)
        if actual_order_has_items? && actual_order_still_valid?
            actual_order.user = user
            actual_order.save
        else
            last_user_order = user.orders.last
            @session[:order_id] = last_user_order.id if last_user_order
        end
    end

    def actual_order_has_items?
        return false unless @session[:order_id] 
        actual_order && actual_order.order_items.count > 0
    end

    def actual_order_still_valid?
        return false unless @session[:order_id] 
        actual_order && actual_order.valid_ttl?
    end

    def actual_order
        @actual_order ||= Order.find(@session[:order_id])
    end
end
