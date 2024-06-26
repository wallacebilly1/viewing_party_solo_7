require 'rails_helper'

RSpec.describe 'Movie Show Page', type: :feature do
  describe 'When user visits a movies show page', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password", password_confirmation: "password")

      visit login_path

      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password

      click_on "Log In"

      visit movie_path(121)
    end

    it 'They see a button to Create a Viewing Party' do
      expect(page).to have_button("Create Viewing Party for The Lord of the Rings: The Two Towers")

      click_on("Create Viewing Party for The Lord of the Rings: The Two Towers")

      expect(current_path).to eq(new_movie_viewing_party_path(121))
    end

    it 'They see a button to return to the Discover page' do
      expect(page).to have_button("Return to Discover Page")

      click_on("Return to Discover Page")

      expect(current_path).to eq(discover_index_path)
    end

    it 'They see all relevant information for that movie' do
      expect(page).to have_content("The Lord of the Rings: The Two Towers")
      expect(page).to have_content("Vote Average: 8.4")
      expect(page).to have_content("Runtime: 2hr 59min")
      expect(page).to have_content("Genre(s): Adventure, Fantasy, Action")
      expect(page).to have_content("Summary: Frodo Baggins and the other members")
      
      within "#actors" do
        expect(page).to have_content("Cast:")
        expect(page).to have_content("Elijah Wood as Frodo Baggins")
        expect(page).to have_content("Sean Astin as Samwise 'Sam' Gamgee")
        expect(page).to have_css("div", between: 1..10)
      end

      within "#reviews" do
        expect(page).to have_content("Review Count: 6")
        expect(page).to have_css("div", count: 6)
        expect(page).to have_content("Author: NeoBrowser")
        expect(page).to have_content("Review: Peter Jackson has always maintained")
      end
    end

    it "They see a link to 'Get Similar Movies'" do
      expect(page).to have_selector(:link_or_button, 'Get Similar Movies')

      click_on("Get Similar Movies")

      expect(current_path).to eq movie_similar_index_path(121)
    end
  end
end