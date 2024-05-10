class MovieFacade  
  def initialize(movie_id = '')
    @movie_id = movie_id
  end

  def movie
    service = MovieService.new

    json = service.details(@movie_id)

    @movie = Movie.new(json)
  end

  def similar 
    service = MovieService.new

    json = service.similar(@movie_id)

    @movies = json[:results].map do |movie_data|
      Movie.new(movie_data)
    end

    @movies[0..4]
  end

  def top_movie_cast
    movie.cast[0..9]
  end

  def where_to_buy
    service = MovieService.new
    service.movie_logos_for_purchase(@movie_id)
  end

  def where_to_rent
    service = MovieService.new
    service.movie_logos_for_rental(@movie_id)
  end

  def viewing_party_movie(movie_id)
    service = MovieService.new
    json = service.details(movie_id)
    Movie.new(json)
  end
end