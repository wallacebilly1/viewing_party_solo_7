class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @keyword = params[:keyword]
    
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = "8b83dd47b8fe1e7341c8bad428c68464"
    end

    response = conn.get("/3/movie/top_rated")
    
    json = JSON.parse(response.body, symbolize_names: true)
    
    @movies = json[:results]
  end
end