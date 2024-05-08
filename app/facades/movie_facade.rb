class MovieFacade
  attr_reader :keyword
  
  def initialize(keyword)
    @keyword = keyword
  end

  def movies
    service = MovieService.new
    
    if @keyword == "top 20rated"
      json = service.top_rated_movies

      @movies = json[:results].map do |movie_data|
        Movie.new(movie_data)
      end
    else 
      json = service.movies_by_title(@keyword)

      @movies = json[:results].map do |movie_data|
        Movie.new(movie_data)
      end
    end
  end
end