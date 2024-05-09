require 'rails_helper'

RSpec.describe 'Show Viewing Party', type: :feature do
  describe 'When user visits their viewing party show page', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'Sam', email: 'sam@email.com')
      @user2 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @party = ViewingParty.create!(date: "06/30/2024", start_time: "07:25", duration: 200, movie_id: 121, movie_duration: 179)
      UserParty.create!(user_id: @user1.id, viewing_party_id: @party.id, host: true)
      UserParty.create!(user_id: @user2.id, viewing_party_id: @party.id, host: false)

      visit user_movie_viewing_party_path(@user1, 121, @party)
    end

    it 'They see logos of video providers for where they can buy the movie' do
      within "#buy" do
        expect(page).to have_css("img")
      end
    end

    it 'They see logos of video providers for where they can rent the movie' do
      within "#rent" do
        expect(page).to have_css("img")
      end
    end

    it "They see a data attribution for JustWatch" do
      expect(page).to have_content("Buy/Rent data provided by JustWatch")
    end
  end
end