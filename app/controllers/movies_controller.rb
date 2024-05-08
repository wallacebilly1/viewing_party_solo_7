class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @keyword = params[:keyword]
    
    if @keyword == "top 20rated"
      conn = Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
        faraday.params["api_key"] = Rails.application.credentials.movies[:key]
      end

      response = conn.get("movie/top_rated")
      
      json = JSON.parse(response.body, symbolize_names: true)
      
      @movies = json[:results]
    
    else 
      conn = Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
        faraday.params["api_key"] = Rails.application.credentials.movies[:key]
      end

      search = @keyword.gsub(" ", "%20")

      response = conn.get("search/movie?query=#{search}&limit=20")

      json = JSON.parse(response.body, symbolize_names: true)
      
      @movies = json[:results]
    end
  end

  def show
    
  end
end