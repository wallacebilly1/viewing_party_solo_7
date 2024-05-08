require "rails_helper"

RSpec.describe Movie do
  it "exists" do
    attrs = {
      id: "1",
      original_title: "My Movie",
      vote_average: "8.6"
    }

    movie = Movie.new(attrs)

    expect(movie).to be_a Movie
    expect(movie.id).to eq("1")
    expect(movie.title).to eq("My Movie")
    expect(movie.vote_average).to eq("8.6")
  end
end