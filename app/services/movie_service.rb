class MovieService
  def conn
    conn = Faraday.new(url: "https://api.themoviedb.org/3/") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.movies[:key]
      faraday.params["append_to_response"] = "credits,reviews"
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def details(movie_id)
    get_url("movie/#{movie_id}")
  end
end