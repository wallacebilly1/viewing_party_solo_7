class MovieService
  def conn
    conn = Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.movies[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def top_rated_movies
    get_url("movie/top_rated")
  end

  def movies_by_title(title)
    search = title.gsub(" ", "%20")
    get_url("search/movie?query=#{search}&limit=20")
  end
end