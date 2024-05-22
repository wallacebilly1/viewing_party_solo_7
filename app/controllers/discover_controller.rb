class DiscoverController < ApplicationController
  def index
    if session[:user_id] == current_user.id

    else 
      render file: "public/404.html"
    end
  end
end