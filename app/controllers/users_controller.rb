class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if session[:user_id] == @user.id
      @facade = MovieFacade.new
    else
      redirect_to root_path
      flash[:error] = "You must be logged in to view your user dashboard"
    end
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.new(user_params)

    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = 'Successfully Created New User'
      redirect_to user_path(new_user)
    else
      flash[:error] = "#{error_message(new_user.errors)}"
      redirect_to register_user_path
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end