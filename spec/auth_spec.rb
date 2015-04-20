require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "testing_username"
      fill_in 'Password', :with => "biscuits"
      click_button "Sign Up"
    end

    scenario "redirects to user show page after signup" do
      expect(page).to have_content "testing_username"
      expect(page).to_not have_content "Sign Up"
    end

    scenario "shows username on the homepage after signup" do
      visit users_url
      expect(page).to have_content "testing_username"
      expect(page).to_not have_content "Sign Up"
    end

    # scenario "has a logout button" do
    #   expect(page).to have_content "log out"
    #
    #
    # scenario "redirects on log out"
    #
    #
    # scenario "username not present"

  end

end
