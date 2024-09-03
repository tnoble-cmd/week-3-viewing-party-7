require 'rails_helper'

RSpec.describe "Logging In", type: :feature do
  
  it "can navigate to the log in page, display form, and have correct CSS id's" do
    visit root_path
    click_button "Log In"

    expect(current_path).to eq(login_path)

    within "#email-field" do
      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
    end

    within "#password-field" do
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
    end

    within "#submit-button" do
      expect(page).to have_button("Log In")
    end
  end
  
  it "can log in with valid credentials" do
    user = User.create!(name: 'funbucket13', email: 'testemail1@gmail.com', password: 'testpassword')

    visit root_path
    click_button "Log In"

    expect(current_path).to eq(login_path)

    within "#email-field" do
      fill_in :email, with: user.email
    end

    within "#password-field" do
      fill_in :password, with: user.password
    end

    within "#submit-button" do
      click_button "Log In"
    end
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with invalid credentials - The most sad path" do
    user = User.create!(name: 'funbucket13', email: 'testemail1@gmail.com', password: 'testpassword')

    visit root_path
    click_button "Log In"

    within "#email-field" do
      fill_in :email, with: "wrongemail@gmail.com"
    end

    within "#password-field" do
      fill_in :password, with: user.password
    end

    within "#submit-button" do
      click_button "Log In"
    end

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid email or password")
  end
end