require 'rails_helper'

RSpec.describe 'Discover Page', type: :feature do
  describe 'When user visits "/users/:id/discover"' do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')

      visit user_discover_index_path(@user1)
    end

    it 'They see a "Find Top Rated Movies" button' do
      expect(page).to have_button('Find Top Rated Movies')

      click_button 'Find Top Rated Movies'

      expect(current_path).to eq("/users/#{@user1.id}/movies")
    end

    it 'They see a text field to enter keyword(s) to search for a movie title and a button to submit the search' do
      expect(page).to have_field("Search by Movie Title")

      fill_in :keyword, with: "Lord of the Rings"

      click_button 'Find Movies'

      expect(current_path).to eq("/users/#{@user1.id}/movies")
    end
  end
end