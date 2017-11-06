class UsersController < ApplicationController
  def new
    redirect_to root_url unless @current_user.id.nil?
    @user = User.new
  end

  def create
    @user = User.create!(user_params)
    AuthenticationHelper.new(session).authenticate(@user)
    redirect_to redirect_to_param["redirect_to"] if redirect_to_param["redirect_to"]
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end

  def redirect_to_param
    params.permit(:redirect_to)
  end
end
