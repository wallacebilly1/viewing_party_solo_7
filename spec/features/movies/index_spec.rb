require 'rails_helper'

RSpec.describe 'Movies Results Page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password", password_confirmation: "password")

    visit login_path

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    click_on "Log In"
  end

  describe "When a user visits the Movies Index page via search or top 20" do
    it 'They see a button to Return to Discover Page', :vcr do
      visit movies_path(keyword: "top 20rated")

      expect(page).to have_button("Return to Discover Page")

      click_button("Return to Discover Page")

      expect(current_path).to eq(discover_index_path)

      visit movies_path(keyword: "Lord of the Rings")

      expect(page).to have_button("Return to Discover Page")

      click_button("Return to Discover Page")

      expect(current_path).to eq(discover_index_path)
    end
  end

  describe "When a user clicks 'Find Top Rated Movies'", :vcr do
    before(:each) do
      visit discover_index_path

      click_button("Find Top Rated Movies")
    end

    it 'They see the top 20 rated movies' do
      expect(page).to have_css("#search_results div", count: 20)

      within("#search_results") do
        expect(page).to have_content("Shawshank Redemption")
        expect(page).to_not have_content("Cats")
      end
    end

    it 'They see the title and vote average for each movie' do
      within ("#movie-278") do
        expect(page).to have_content("Shawshank Redemption")
        expect(page).to have_content("Average Score: 8.7")
      end

      within ("#movie-238") do
        expect(page).to have_content("The Godfather")
        expect(page).to have_content("Average Score: 8.7")
      end
    end

    it 'When the user clicks on the title, they are taken to that movies details page' do
      within ("#movie-278") do
        click_on("Shawshank Redemption")
        expect(current_path).to eq movie_path("278")
      end
    end
  end

  describe "When a user searches for a movie", :vcr do
    before(:each) do
      visit discover_index_path
      fill_in :keyword, with: "Lord of the Rings"
      click_button 'Find Movies'
    end

    it 'They see up to 20 movies that match their search' do
      expect(page).to have_css("#search_results div", between: 0..20)
      
      within("#search_results") do
        expect(page).to have_content("The Lord of the Rings: The Two Towers")
        expect(page).to_not have_content("Cats")
      end
    end

    it 'They see the title and vote average for each movie' do
      within ("#movie-120") do
        expect(page).to have_content("The Lord of the Rings: The Fellowship of the Ring")
        expect(page).to have_content("Average Score: 8.4")
      end

      within ("#movie-121") do
        expect(page).to have_content("The Lord of the Rings: The Two Towers")
        expect(page).to have_content("Average Score: 8.4")
      end
    end

    it 'When the user clicks on the title, they are taken to that movies details page' do
      within ("#movie-120") do
        click_on("The Lord of the Rings: The Fellowship of the Ring")
        expect(current_path).to eq movie_path("120")
      end
    end
  end
end