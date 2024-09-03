require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: "test123"
    fill_in :user_password_confirmation, with: "test123"
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  #the saddest of paths
  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: 'test123')

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with: "test123"
    fill_in :user_password_confirmation, with: "test123"
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  #also the saddest of paths
  it 'does not create a user if password and password confirmation do not match' do 
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'userone@gmail.com'
    fill_in :user_password, with: "test123"
    fill_in :user_password_confirmation, with: "test1234"

    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
