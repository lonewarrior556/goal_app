require 'rails-helper'

feature "Comments" do

  feature "Creating Comments" do

    scenario "Comment can be made on a User"

    scenario "Comment can be made on a Goal"

    scenario "Must be logged in to make a comment"


  end

  feature "Showing Comments" do

    scenario "Comments show on user's show page"

    scenario "Comments show on goal's show page"

  end

  feature "Edit/Update/Remove Comments" do

    scenario "Users can edit their own comments"

    scenario "Users can Delete their own comments"

    feature "Other users' comments" do

      scenario "Users can't delete other users' comments"

      scenario "Users can't edit other comments"

    end

  end








end
