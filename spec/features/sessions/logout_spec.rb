require 'rails_helper'

RSpec.describe "Logging Out" do
  it "can only see log out button once logged in" do
    user = User.create!(name: "Meg", email: "meg@test.com", password: "test", password_confirmation: "test")

    visit root_path

    expect(page).to have_button("Log In Here")
    expect(page).to have_button("Create New User")

    click_on "Log In Here"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"
    
    visit root_path

    expect(page).to have_button("Log Out")
    expect(page).to_not have_button("Log In Here")
    expect(page).to_not have_button("Create New User")
  end

  it "returns you to the landing page when logged out" do
    user = User.create!(name: "Meg", email: "meg@test.com", password: "test", password_confirmation: "test")
  
    visit login_path
  
    fill_in :email, with: user.email
    fill_in :password, with: "test"
  
    click_on "Log In"

    click_on "Log Out"

    expect(current_path).to eq(root_path)
  
    expect(page).to_not have_button("Log Out")
    expect(page).to have_button("Log In Here")
    expect(page).to have_button("Create New User")
  end
end