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
    @user[:email] = @user[:email].downcase
    @new_user = User.new(user_params)

    if @new_user.save
      flash[:success] = 'Successfully Created New User'
      redirect_to user_path(@new_user)
    else
      flash[:error] = "#{error_message(@new_user.errors)}"
      redirect_to register_user_path
    end
  end

  def login_form

  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      if user.admin?
        redirect_to admin_dashboard_path
      elsif user.manager?
        redirect_to root_path
      else
        redirect_to user_path(user)
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end