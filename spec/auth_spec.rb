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

    scenario "signs user in after sign up" do
      expect(page).to have_content "Log Out"
      expect(page).to_not have_content("Sign In")
      expect(page).to_not have_content("Sign Up")
    end
  end


  feature "Sign in/ Sign out" do

    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "testing_username"
      fill_in 'Password', :with => "biscuits"
      click_button "Sign Up"
      click_button "Log Out"
    end

    scenario "User can Sign In" do
      click_link "Sign In"
      fill_in 'Username', :with => "testing_username"
      fill_in 'Password', :with => "biscuits"
      click_button "Sign In"
      expect(page).to have_content "Log Out"
      expect(page).to_not have_content("Sign In")
      expect(page).to_not have_content("Sign Up")
      expect(page).to have_content "Welcome, testing_username"
    end

    scenario "redirects to login/signin page when not logged in" do
      visit user_url(1)
      expect(page).to have_content("Sign In")
      expect(page).to_not have_content("testing_username")
    end




  end
end

#     scenario "log in redirects to user page"
#       click on
#
#     #
#     # scenario "redirects on log out"
#     #
#     #
#     # scenario "username not present"
#
#   end
#
# end
