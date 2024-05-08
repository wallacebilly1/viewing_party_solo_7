require 'rails_helper'

RSpec.describe MovieFacade do
  it 'exists and has a movie id attr', :vcr do
    facade = MovieFacade.new("3")

    expect(facade).to be_a(MovieFacade)
    expect(facade.instance_variable_get(:@movie_id)).to eq("3")
  end

  it 'returns an array of Member objects', :vcr do
    facade = MovieFacade.new("3")

    expect(facade.movie).to be_a(Movie)
  end
end
