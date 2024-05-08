class MovieSearchFacade  
  def initialize(keyword)
    @keyword = keyword
  end

  def movies
    service = MovieSearchService.new
    
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