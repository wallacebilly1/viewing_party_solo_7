class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @facade = MovieFacade.new
  end

  def create
    @user = user_params
    @user[:username] = @user[:username].downcase
    @new_user = User.new(user_params)
    if @new_user.save
      flash[:success] = 'Successfully Created New User'
      redirect_to user_path(@new_user)
    else
      flash[:error] = "#{error_message(@new_user.errors)}"
      redirect_to register_user_path
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end