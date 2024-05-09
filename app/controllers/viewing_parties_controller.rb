class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:movie_id])
  end

  def create
    @user = User.find(params[:user_id])
    redirect_to user_path(@user)
  end
end