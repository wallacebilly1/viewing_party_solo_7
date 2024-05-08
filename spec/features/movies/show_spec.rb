require 'rails_helper'

RSpec.describe 'Movie Show Page', type: :feature do
  describe 'When user visits a movies show page', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')

      visit user_movie_path(@user1, "121")
    end

    xit 'They see a button to Create a Viewing Party' do
      expect(page).to have_button("Create a Viewing Party for Lord of the Rings")

      click_on("Create a Viewing Party for Lord of the Rings")

      expect(current_path).to eq("/users/#{@user1.id}/movies/121/viewing_party/new")
    end

    it 'They see a button to return to the Discover page' do
      expect(page).to have_button("Return to Discover Page")

      click_on("Return to Discover Page")

      expect(current_path).to eq(user_discover_index_path(@user1))
    end

    it 'They see all relevant information for that movie' do
      expect(page).to have_content("The Lord of the Rings: The Two Towers")
      expect(page).to have_content("Vote Average: 8.4")
      expect(page).to have_content("Runtime: 2hr 59min")
      expect(page).to have_content("Genre(s): Adventure, Fantasy, Action")
      expect(page).to have_content("Summary: Frodo and Sam are trekking")
      
      within "#actors" do
        expect(page).to have_content("Cast:")
        expect(page).to have_content("Elijah Wood as Frodo Baggins")
        expect(page).to have_content("Sean Astin as Samwise Gamgee")
        expect(page).to have_css("div", between: 1..10)
      end

      within "#reviews" do
        expect(page).to have_content("Review Count: 6")
        expect(page).to have_css("div", count: 6)
        expect(page).to have_content("Author: NeoBrowser")
        expect(page).to have_content("Review: Peter Jackson has always maintained")
      end
    end
  end
end