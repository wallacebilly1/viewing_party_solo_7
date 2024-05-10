require 'rails_helper'

RSpec.describe 'Similar Movies Index Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    visit user_movie_similar_index_path(@user1, 121)
  end

  it "They see a list of similar movies" do
    expect(page).to have_css("div", between: 1..10)
  end

  it "They see movie information for each movie on the list" do
    within "movie-280" do
      expect(page).to have_content("Terminator 2: Judgment Day")
      expect(page).to have_content("Description: Set ten years after the events")
      expect(page).to have_content("Release Date: 1991-07-03")
      expect(page).to have_css("img")
      expect(page).to have_content("Vote Average: 8.1")
    end
  end
end