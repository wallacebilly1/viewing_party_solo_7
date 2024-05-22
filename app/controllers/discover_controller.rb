class DiscoverController < ApplicationController
  def index
    if current_user

    else 
      render file: "public/404.html"
    end
  end
end