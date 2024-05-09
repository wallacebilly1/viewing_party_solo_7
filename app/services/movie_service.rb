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

  def details(movie_id)
    get_url("movie/#{movie_id}?append_to_response=credits,reviews")
  end

  def provider_data(movie_id)
    get_url("movie/#{movie_id}/watch/providers")
  end

  def movie_logo_urls_for_purchase(movie_id)
    provider_data(movie_id)[:results][:US][:buy].map do |provider|
      provider[:logo_path]
    end
  end
  
  def movie_logo_urls_for_rental(movie_id)
    provider_data(movie_id)[:results][:US][:rent].map do |provider|
      provider[:logo_path]
    end
  end

  def movie_logos_for_purchase(movie_id)
    movie_logo_urls_for_purchase(movie_id).map do |url|
      "https://image.tmdb.org/t/p/w500#{url}"
    end
  end

  def movie_logos_for_rental(movie_id)
    movie_logo_urls_for_rental(movie_id).map do |url|
      "https://image.tmdb.org/t/p/w500#{url}"
    end
  end
end