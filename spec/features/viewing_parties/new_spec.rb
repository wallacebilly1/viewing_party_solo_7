require 'rails_helper'

RSpec.describe 'Create New Viewing Party', type: :feature do
  describe 'When a user visits the new viewing party page', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password", password_confirmation: "password")
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com', password: "password", password_confirmation: "password")
      @user3 = User.create!(name: 'Joe', email: 'joe@email.com', password: "password", password_confirmation: "password")
      @user4 = User.create!(name: 'Mary', email: 'mary@email.com', password: "password", password_confirmation: "password")

      visit login_path

      fill_in :email, with: @user1.email
      fill_in :password, with: @user1.password

      click_on "Log In"

      visit new_movie_viewing_party_path(121)
    end
    
    it 'They see the title of the movie' do
      expect(page).to have_content("The Lord of the Rings: The Two Towers")
    end
    
    it 'They see a form to fill in the duration of the party, select a date/time, and add guests' do
      expect(page).to have_field("Duration", with: 179, type: "number")
      expect(page).to have_field("Date", type: "date")
      expect(page).to have_field("Start Time", type: "time")
      expect(page).to have_field("email_address1")
      expect(page).to have_field("email_address2")
      expect(page).to have_field("email_address3")
      expect(page).to have_selector(:link_or_button, 'Create Viewing Party')    
    end
    
    it "When they fill in the form and submit, they're taken to that user's dashboard, with that user indicated as the host" do
      fill_in "Duration", with: '200'
      fill_in "Date", with: '2024/05/30'
      fill_in "Start Time", with: '6:00PM'
      fill_in "email_address1", with: 'sam@email.com'
      fill_in "email_address2", with: 'joe@email.com'
      fill_in "email_address3", with: 'mary@email.com'

      click_button 'Create Viewing Party'

      expect(current_path).to eq(user_dashboard_path)
    end

    it 'when they enter a duration less than the movie length' do
      fill_in "Duration", with: 20
      fill_in "Date", with: '2024/05/30'
      fill_in "Time", with: '6:00PM'
      fill_in "email_address1", with: 'sam@email.com'

      click_button 'Create Viewing Party'

      expect(current_path).to eq(new_movie_viewing_party_path(121))
      expect(page).to have_content('Duration must be longer than the movie length')
    end

    it 'When they fill in form with missing information' do
      fill_in "Duration", with: '200'
      fill_in "Date", with: '2024/05/30'
      fill_in "Time", with: ''
      fill_in "email_address1", with: 'sam@email.com'

      click_button 'Create Viewing Party'

      expect(current_path).to eq(new_movie_viewing_party_path(121))
      expect(page).to have_content("Start time can't be blank")
    end

    it 'When they fill in form with a date that has passed' do
      fill_in "Duration", with: '200'
      fill_in "Date", with: '2000/01/01'
      fill_in "Time", with: '6:00PM'
      fill_in "email_address1", with: 'sam@email.com'

      click_button 'Create Viewing Party'

      expect(current_path).to eq(new_movie_viewing_party_path(121))
      expect(page).to have_content("Date can't be in the past")
    end

    it 'When they fill in form with invalid email format (only somethng@something.something)' do 
      # maybe add in later
    end

    it 'They can create a viewing party without guests' do
      fill_in "Duration", with: '200'
      fill_in "Date", with: '2024/05/30'
      fill_in "Time", with: '6:00PM'

      click_button 'Create Viewing Party'
  
      expect(current_path).to eq(user_dashboard_path)
    end

    it 'When added as a guest to a viewing party, that viewing party shows up on that users dashboard' do
      fill_in "Duration", with: '200'
      fill_in "Date", with: '2024/05/30'
      fill_in "Time", with: '6:00PM'
      fill_in "email_address1", with: 'sam@email.com'
      fill_in "email_address2", with: 'joe@email.com'
      fill_in "email_address3", with: 'mary@email.com'
    
      click_button 'Create Viewing Party'

      click_on "Log Out"

      visit login_path

      fill_in :email, with: @user2.email
      fill_in :password, with: @user2.password

      click_on "Log In"

      visit user_dashboard_path

      expect(page).to have_content("The Lord of the Rings: The Two Towers")
    end
  end
end