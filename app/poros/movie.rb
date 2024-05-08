class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :cast,
              :review_count,
              :reviews

  def initialize(movie_data)
    @id = movie_data[:id]
    @title = movie_data[:original_title]
    @vote_average = movie_data[:vote_average]
    # @runtime = movie_data[:runtime]
    # @genres = movie_data[:id]
    # @summary = movie_data[:overview]
    # @cast = movie_data[:id]
    # @review_count = movie_data[:id]
    # @reviews = movie_data[:id]
  end
end