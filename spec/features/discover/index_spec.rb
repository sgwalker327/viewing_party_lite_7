require 'rails_helper'

RSpec.describe '/discover', type: :feature do
  before do
    @steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
        visit "/users/#{@steve.id}/discover"
  end
  describe "As a user" do
    context "When I visit the '/users/:id/discover' path, where :id, is the id of a valid user" do
      it "I should see a button to Discover Top Rated Movies" do
        expect(page).to have_button("Find Top Rated Movies")
      end

      it "I should see a text field to search by movie title" do
        expect(page).to have_field(:search)
        expect(page).to have_button("Find Movies")
      end

      it "When I click the button 'Find Top Rated Movies', I should be redirected to the movies index page", :vcr do
        click_button "Find Top Rated Movies"

        expect(current_path).to eq(user_movies_path(@steve.id))
      end

      it "When I fill in the text field and click 'Find Movies', I should be redirected to the movies index page", :vcr do
        fill_in :search, with: "The Matrix"
        click_button "Find Movies"

        expect(current_path).to eq(user_movies_path(@steve.id))
      end
    end
  end
end