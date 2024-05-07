require 'rails_helper'

RSpec.describe 'Movies Results Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
  end

  describe "When a user visits the Movies Index page via serach or top 20" do
    it 'They see a button to Return to Discover Page', :vcr do
      visit user_movies_path(@user1, keyword: "top 20rated")

      expect(page).to have_button("Return to Discover Page")

      click_button("Return to Discover Page")

      expect(current_path).to eq(user_discover_index_path(@user1))

      visit user_movies_path(@user1, keyword: "Lord of the Rings")

      expect(page).to have_button("Return to Discover Page")

      click_button("Return to Discover Page")

      expect(current_path).to eq(user_discover_index_path(@user1))
    end
  end

  describe "When a user clicks 'Find Top Rated Movies'", :vcr do
    before(:each) do
      visit user_discover_index_path(@user1.id)
      click_button("Find Top Rated Movies")
    end

    it 'They see the top 20 rated movies' do
      
    end

    it 'They see the title and vote average for each movie' do
      #within a specific movie's section
      #expect page to have title
      #expect page to have a vote average
    end

    it 'When the user clicks on the title, they are taken to that movies details page' do
      #within a specific movie's section
      #click on title
      #expect current path to eq user_movie_path(@user1.id, movie.id)
    end
  end

  describe "When a user searches for a movie", :vcr do
    before(:each) do
      visit user_discover_index_path(@user1.id)
      fill_in :keyword, with: "Lord of the Rings"
      click_button 'Find Movies'
    end

    it 'They see up to 20 movies that match their search' do
      #expect page to have search results section
      #expect there to be 20 items within top 20 section
      #expect those items to be the following: ...
    end

    it 'They see the title and vote average for each movie' do
      #within a specific movie's section
      #expect page to have title
      #expect page to have a vote average
    end

    it 'When the user clicks on the title, they are taken to that movies details page' do
      #within a specific movie's section
      #click on title
      #expect current path to eq user_movie_path(@user1.id, movie.id)
    end
  end
end