require 'rails_helper'

RSpec.describe 'Root Page, Welcome Index', type: :feature do
  describe 'When a user visits the root path "/"' do
    before(:each) do
    @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: "password", password_confirmation: "password")
    @user_2 = User.create!(name: 'Tommy', email: 'tommy_t@gmail.com', password: "password", password_confirmation: "password")

    visit root_path
    end

    it 'They see title of application, and link back to home page' do
      expect(page).to have_content('Viewing Party')
      expect(page).to have_link('Home')
    end

    it 'They see button to create a New User' do
      expect(page).to have_selector(:link_or_button, 'Create New User')
    end

    it "They see a list of existing users, which links to the individual user's dashboard" do
      within("#existing_users") do 
        expect(page).to have_content(User.first.email)
        expect(page).to have_content(User.last.email)
        expect(page).to have_link("#{User.first.email}", href: "users/#{User.first.id}")
        expect(page).to have_link("#{User.last.email}", href: "users/#{User.last.id}")
      end   
    end

    it "They see a link to go back to the landing page (present at the top of all pages)" do
      expect(page).to have_link("Home")
    end
  end
end
