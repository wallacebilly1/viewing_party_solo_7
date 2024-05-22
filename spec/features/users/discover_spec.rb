require 'rails_helper'

RSpec.describe 'Discover Page', type: :feature do
  describe 'When user visits their discover page' do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password", password_confirmation: "password")

      visit login_path

      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password

      click_on "Log In"

      visit discover_index_path
    end

    it 'They see a "Find Top Rated Movies" button', :vcr do
      expect(page).to have_button('Find Top Rated Movies')

      click_button 'Find Top Rated Movies'

      expect(current_path).to eq(movies_path)
    end

    it 'They see a text field to enter keyword(s) to search for a movie title and a button to submit the search', :vcr do
      expect(page).to have_field("Search by Movie Title")

      fill_in :keyword, with: "Lord of the Rings"

      click_button 'Find Movies'

      expect(current_path).to eq(movies_path)
    end
  end
end