require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create!(name: "Meg", email: "meg@test.com", password: "test", password_confirmation: "test")

    visit root_path

    click_on "Log In Here"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"
    log_in_user = User.last

    expect(current_path).to eq(user_dashboard_path)

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with bad credentials" do
    user = User.create!(name: "Meg", email: "meg@test.com", password: "test", password_confirmation: "test")
  
    visit login_path
  
    fill_in :email, with: user.email
    fill_in :password, with: "123"
  
    click_on "Log In"
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  it "stays logged in after leaving the site" do
    user = User.create!(name: "Meg", email: "meg@test.com", password: "test", password_confirmation: "test")
  
    visit login_path
  
    fill_in :email, with: user.email
    fill_in :password, with: "test"

    click_on "Log In"
    log_in_user = User.last

    visit "https://www.google.com"

    visit user_dashboard_path
  end
end