class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @facade = MovieFacade.new(params[:movie_id])
  end
end