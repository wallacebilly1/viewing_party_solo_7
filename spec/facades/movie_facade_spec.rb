require 'rails_helper'

RSpec.describe MovieFacade do
  before(:each) do
    @facade = MovieFacade.new(121)
  end

  it 'exists and has a movie id attr', :vcr do
    expect(@facade).to be_a(MovieFacade)
    expect(@facade.instance_variable_get(:@movie_id)).to eq(121)
  end

  it 'returns a movie object', :vcr do
    expect(@facade.movie).to be_a(Movie)
  end

  it 'returns an array of similar movies', :vcr do
    expect(@facade.similar).to be_an(Array)
    expect(@facade.similar.count).to eq 5

    @facade.similar.each do |movie|
      expect(movie).to be_a(Movie)
    end
  end

  it 'returns the top 10 listed cast members', :vcr do
    expect(@facade.top_movie_cast).to be_an(Array)
    expect(@facade.top_movie_cast.count).to eq 10

    @facade.top_movie_cast.each do |member|
      expect(member).to be_a(String)
    end
  end

  it 'returns an array of logo paths for where to buy a movie', :vcr do
    expect(@facade.where_to_buy).to be_an(Array)

    @facade.where_to_buy.each do |site|
      expect(site).to be_a(String)
    end
  end
  
  it 'returns an array of logo paths for where to rent a movie', :vcr do
    expect(@facade.where_to_rent).to be_an(Array)

    @facade.where_to_rent.each do |site|
      expect(site).to be_a(String)
    end
  end

  it 'returns a movie object', :vcr do
    expect(@facade.viewing_party_movie(121)).to be_a(Movie)
  end

end
