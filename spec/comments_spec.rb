require 'rails_helper'

feature "Comments" do
  given(:test) { User.find_by(username: 'test') }
  given(:goal) { Goal.find_by(title: "Learn Rspec")}
  before(:each) do
    visit new_user_url
    fill_in 'Username', :with => "test"
    fill_in 'Password', :with => "biscuits"
    click_button "Sign Up"

    click_button "Add Goal"
    fill_in "Title", :with => "Learn Rspec"
    click_button "Set Goal"

    click_button "Log Out"
    click_link "Sign Up"
    fill_in 'Username', :with => "test2"
    fill_in 'Password', :with => "biscuits"
    click_button "Sign Up"
  end

  feature "Creating Comments" do

    scenario "Comment can be made on a User" do
      visit user_url(test)
      fill_in "New Comment", :with => "I'm a user comment"
      click_button "Add Comment"
      expect(page).to have_content("I'm a user comment")
    end

    scenario "Comment can be made on a Goal" do
      visit goal_url(goal)
      fill_in "New Comment", :with => "I'm a goal comment"
      click_button "Add Comment"
      expect(page).to have_content("I'm a goal comment")
    end


    scenario "Must be logged in to make a comment" do
      click_button "Log Out"
      visit user_url(test)
      expect(page).to_not have_content("Add Comment")
      visit goal_url(goal)
      expect(page).to_not have_content("Add Comment")
    end

  end


  feature "Edit/Update/Remove Comments" do
    before(:each) do
      visit user_url(test)
      fill_in "New Comment", :with => "I'm a user comment"

      click_button('Add Comment')

      visit goal_url(goal)
      fill_in "New Comment", :with => "I'm a goal comment"
      click_button('Add Comment')
    end

    scenario "Users can Delete their own comments" do
      visit user_url(test)

      expect(page).to have_content("remove comment")
      click_button "remove comment"
      expect(page).to_not have_content("I'm a user comment")

      visit goal_url(goal)
      expect(page).to have_content("remove comment")
      click_button "remove comment"
      expect(page).to_not have_content("I'm a goal comment")

    end

    scenario "Users can't delete other users' comments" do
      click_button "Log Out"
      visit new_user_url
      fill_in 'Username', :with => "testing"
      fill_in 'Password', :with => "biscuits"
      click_button "Sign Up"
      visit user_url(test)
      expect(page).to_not have_content("remove comment")
      visit goal_url(goal)
      expect(page).to_not have_content("remove comment")
    end

  end

end
