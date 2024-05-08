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
    @runtime = movie_data[:runtime]
    @genres = movie_data[:genres]
    @summary = movie_data[:overview]
    # .dig returns nil if the key is not present, meaning you don't have to initialize with these attributes
    @cast = movie_data.dig(:credits, :cast)
    @review_count = movie_data.dig(:reviews, :total_results)
    @reviews = movie_data.dig(:reviews, :results)
  end

  def runtime
    if @runtime != nil
      hours = @runtime / 60
      minutes = @runtime % 60

      formatted_runtime = ""
      formatted_runtime += "#{hours}hr " if hours > 0
      formatted_runtime += "#{minutes}min" if minutes > 0
    end
  end

  def genres
    if @genres != nil
      @genres.map do |genre|
        genre[:name]
      end.join(", ")
    end
  end

  def cast
    @cast.map do |cast|
      actor = cast[:name]
      role = cast[:character]
      "#{actor} as #{role}"
    end
  end

  def reviews
    @reviews.map do |review|
      author = review[:author]
      content = review[:content]
      "Author: #{author} - Review: #{content}"
    end
  end
end