require 'rails_helper'

RSpec.describe 'Movie Show Page', type: :feature do
  describe 'When user visits a movies show page', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')

      visit user_movie_path(@user1, "121")
    end

    it 'They see a button to Create a Viewing Party' do
      # file path for viewing party - (/users/:user_id/movies/:movie_id/viewing_party/new) 
    end

    it 'They see a button to return to the Discover page' do

    end

    it 'They see all relevant information for that movie' do
      # - Movie Title - @movie_info(original_title)
      # - Vote Average of the movie - @movie_info(vote_average)
      # - Runtime in hours & minutes - @movie_info(runtime(in mins))
      # - Genre(s) associated to movie - @movie_info(genres)
      # - Summary description - @movie_info(overview)
      # - List the first 10 cast members (characters & actress/actors) - @movie_cast
      # - Count of total reviews - @movie_reviews
      # - Each review's author and information - @movie_reviews
    end
  end
end