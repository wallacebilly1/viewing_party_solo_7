class MovieFacade  
  def initialize(movie_id)
    @movie_id = movie_id
  end

  def movie
    service = MovieService.new
    
    json = service.details(@movie_id)

    @movie = Movie.new(json)
  end
end