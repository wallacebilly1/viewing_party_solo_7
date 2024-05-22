class WelcomeController < ApplicationController
  def index
    @users = User.all
    # plain text cookie: 
    # cookies[:greeting] = "Hello there!"
    
    # signed cookie:
    # cookies.signed[:greeting] = "hello there!"

    # encrypted cookie:
    cookies.encrypted[:greeting] = "hello there"
  end
end
