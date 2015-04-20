

feature "Goals" do
  before(:each) do
    visit new_user_url
    fill_in 'Username', :with => "test"
    fill_in 'Password', :with => "biscuits"
    click_button "Sign Up"
  end

  scenario "should allow user to create goals" do
    click_button "Add Goal"
    fill_in "Title", :with => "Learn Rspec"
    click_button "Set Goal"

    expect(page).to have_content("Add Goal")
  end

  feature "Editing Goals" do

    before(:each) do
      click_button "Add Goal"
      fill_in "Title", :with => "Learn Rspec"
      click_button "Set Goal"
    end

    scenario "should allow user to view their goal's show page" do
      visit goal_url(1)
      expect(page).to have_content("Edit Goal")
      expect(page).to have_content("Learn Rspec")
      expect(page).to_not have_content("Sign In")
    end

    scenario "should allow users to edit their goals" do
      visit goal_url(1)
      click_button "Edit Goal"
      expect(page).to have_content("Edit Goal")
      fill_in "Title", :with => "Edit Learn Rspec"
      click_button "Update Goal"
      expect(page).to have_content("Edit Learn Rspec")
    end


    scenario "should show goals on users show page" do
      visit user_url(1)
      expect(page).to have_content("Your Goals")
      expect(page).to have_content("Learn Rspec")
      expect(page).to_not have_content("Sign In")
    end

    scenario "should allow user to delete their goals" do
      visit user_url(1)
      expect(page).to have_content("remove goal")
      click_button "remove goal"
      expect(page).to_not have_content("Learn Rspec")
      expect(page).to have_content("Your Goals")
    end



    feature "can't touch other peoples goals" do
      before(:each) do
        click_button("Log Out")
        visit new_user_url
        fill_in 'Username', :with => "test2"
        fill_in 'Password', :with => "biscuits"
        click_button "Sign Up"
        visit(user_url(1))
      end

      scenario "Destroy button should not be visible to other users" do
        expect(page).to_not have_content("remove goal")
        expect(page).to have_content("Your Goals")
      end

      scenario "Cannot add goals if not your page" do
        expect(page).to_not have_content("Add Goal")
      end

      scenario "Cannot Edit other people's goals" do
        click_link "Learn Rspec"
        expect(page).to_not have_content("Edit Goal")
        visit edit_goal_url(1)
        expect(page).to_not have_content("Edit Goal")
        expect(page).to have_content("All the Users")
      end



    end

    feature "private goals" do
      before(:each) do
        click_button "Add Goal"
        fill_in "Title", :with => "Private Goal"
        check "private"
        click_button "Set Goal"
      end

      scenario "should show private goals for user" do
        expect(page).to have_content("Private Goal")
      end

      scenario "should hide private goals from other user" do
        click_button("Log Out")
        visit new_user_url
        fill_in 'Username', :with => "test2"
        fill_in 'Password', :with => "biscuits"
        click_button "Sign Up"
        visit(user_url(1))
        # save_and_open_page
        expect(page).to_not have_content("Private Goal")
        expect(page).to have_content("Learn Rspec")
        visit goal_url(2)
        expect(page).to_not have_content("Private Goal")
      end



    end

  end
end
