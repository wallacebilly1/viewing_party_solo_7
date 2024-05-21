class DiscoverController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    unless cookies.encrypted[:greeting]
      cookies.encrypted[:greeting] = 'Howdy!'
    end
  end
end