require "rails_helper"

RSpec.describe Movie do
  before(:each) do
    @movie_attr = {
      genres: [
        { id: 12, name: "Adventure" },
        { id: 14, name: "Fantasy" },
        { id: 28, name: "Action" }
      ],
      id: 121,
      original_title: "The Lord of the Rings: The Two Towers",
      overview: "Frodo and his gang, etc.",
      vote_average: 8.4,
      runtime: 179,
      credits: {
        cast: [
          { name: "Elijah Wood", character: "Frodo Baggins" },
          { name: "Sean Astin", character: "Samwise Gamgee" },
          { name: "Andy Serkis", character: "Gollum / Smeagol" },
          { name: "Viggo Mortenson", character: "Aragorn" },
          { name: "Ian McKellen", character: "Gandalf" },
          { name: "Bernard Hill", character: "Théoden" },
          { name: "Dominic Monaghan", character: "Meriadoc 'Merry' Brandybuck" },
          { name: "Billy Boyd", character: "Peregrin 'Pippin' Took" },
          { name: "John Rhys-Davies", character: "Gimli / Treebeard (Voice)" },
          { name: "Orlando Bloom", character: "Legolas" }
        ]
      },
      reviews: {
        results: [
          { author: "NeoBrowser", content: "Peter Jackson bla bla..." },
          { author: "JPV852", content: "Frodo, what a guy." }
        ],
        total_results: 2
      }
    }

    @movie = Movie.new(@movie_attr)
  end

  it "exists" do
    expect(@movie).to be_a Movie
    expect(@movie.id).to eq(121)
    expect(@movie.title).to eq("The Lord of the Rings: The Two Towers")
    expect(@movie.vote_average).to eq(8.4)
  end

  it 'formats runtime in xhr xxmin format' do
    expect(@movie.runtime).to eq("2hr 59min")
  end

  it 'combines all genres into a single string' do
    expect(@movie.genres).to eq("Adventure, Fantasy, Action")
  end

  it 'creates an array of actor/role hashes for the first 10 actors' do
    expect(@movie.cast).to be_an(Array)
    @movie.cast.each do |cast|
      expect(cast).to be_a(String)
    end
  end

  it 'creates an array of author/content hashes for all reviews' do
    expect(@movie.reviews).to be_an(Array)
    @movie.reviews.each do |review|
      expect(review).to be_a(String)
    end
  end
end