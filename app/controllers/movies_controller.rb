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
    @user = User.find(params[:user_id])
    @movie_id = params[:id]

    conn = Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.movies[:key]
      faraday.params["append_to_response"] = "credits,reviews"
    end

    response = conn.get("movie/#{@movie_id}")

    json = JSON.parse(response.body, symbolize_names: true)
    
    @movie_info = json[:results]

    # @movie_credits = https://api.themoviedb.org/3/movie/{movie_id}/credits
    # @movie_reviews = https://api.themoviedb.org/3/movie/{movie_id}/reviews

  end
end