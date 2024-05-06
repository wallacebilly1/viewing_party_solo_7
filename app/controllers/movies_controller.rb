class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @keyword = params[:keyword]
  end
end