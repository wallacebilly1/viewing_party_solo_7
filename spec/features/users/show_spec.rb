require 'rails_helper'

RSpec.describe 'Show User Dashboard', type: :feature do
  describe 'When user visits their user dashboard' do
    before(:each) do
      @user1 = User.create!(name: 'Sam', email: 'sam@email.com')
      @user2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @party1 = ViewingParty.create!(date: "2024/06/30", start_time: "07:25", duration: 200, movie_id: 121, movie_duration: 179)
      @party2 = ViewingParty.create!(date: "2024/07/15", start_time: "06:35", duration: 220, movie_id: 122, movie_duration: 201)
      UserParty.create!(user_id: @user1.id, viewing_party_id: @party1.id, host: true)
      UserParty.create!(user_id: @user2.id, viewing_party_id: @party1.id, host: false)

      UserParty.create!(user_id: @user1.id, viewing_party_id: @party2.id, host: false)
      UserParty.create!(user_id: @user2.id, viewing_party_id: @party2.id, host: true)

      visit user_path(@user1)
    end

    it 'They see a Discover Movies button that redirects to a discover page', :vcr do
      expect(page).to have_button('Discover Movies')

      click_button 'Discover Movies'

      expect(current_path).to eq(user_discover_index_path(@user1))
    end

    it 'They see all viewing parties they have been invited to or are hosting', :vcr do
      expect(page).to have_content("Lord of the Rings: The Two Towers")
      expect(page).to have_content("Lord of the Rings: The Return of the King")
    end

    it 'They see all information about a viewing party they are hosting', :vcr do
      within "#party-#{@party1.id}" do
        expect(page).to have_css("img")
        expect(page).to have_content("The Lord of the Rings: The Two Towers")
        expect(page).to have_link("The Lord of the Rings: The Two Towers")
        expect(page).to have_content("2024/06/30 at 07:25")
        expect(page).to have_content("Host: Sam")
        expect(page).to have_content("Who's Coming?\nSam Tommy")
      end
    end

    it 'They see all information about a viewing party they are invited to', :vcr do
      within "#party-#{@party2.id}" do
        expect(page).to have_css("img")
        expect(page).to have_content("The Lord of the Rings: The Return of the King")
        expect(page).to have_link("The Lord of the Rings: The Return of the King")
        expect(page).to have_content("2024/07/15 at 06:35")
        expect(page).to have_content("Host: Tommy")
        expect(page).to have_content("Who's Coming?\nSam Tommy")
        expect(find(:css, ".bold_user").text).to have_content("Sam")
      end
    end

    it 'They are taken to the movie show page when clicking on the title of a movie', :vcr do
      click_on("The Lord of the Rings: The Two Towers")
      expect(current_path).to eq(user_movie_path(@user1, 121))
    end
  end
end