require 'rails_helper'

RSpec.describe 'Show User Dashboard', type: :feature do
  describe 'When user visits "/users/:id"' do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com')

      visit user_path(@user1)
    end

    it 'They see a Discover Movies button that redirects to a discover page' do
      expect(page).to have_button('Discover Movies')

      click_button 'Discover Movies'

      expect(current_path).to eq("/users/:id/discover")
    end
  end
end