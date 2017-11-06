class LoginsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            AuthenticationHelper.new(session).authenticate(user)
            redirect_to root_url, flash: { info: 'Logged in!' }
        else
            flash.now[:warning] = 'Email or password is invalid'
            render :new
        end
    end

     def destroy
        session[:user_id] = nil
        session[:order_id] = nil
        redirect_to root_url
    end
end
