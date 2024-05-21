class SessionsController < ApplicationController
  def new

  end
  
  def create
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
      render :new
    end
  end
end