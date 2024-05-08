require 'rails_helper'

RSpec.describe MovieSearchFacade do
  it 'exists and has a keyword attr', :vcr do
    facade = MovieSearchFacade.new("Lord of the Rings")

    expect(facade).to be_a(MovieSearchFacade)
    expect(facade.instance_variable_get(:@keyword)).to eq("Lord of the Rings")
  end

  it 'returns an array of movie objects', :vcr do
    facade = MovieSearchFacade.new("Lord of the Rings")

    expect(facade.movies).to be_an(Array)

    facade.movies.each do |movie|
      expect(movie).to be_a(Movie)
    end
  end
end
