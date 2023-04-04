require 'rails_helper'

RSpec.describe '/users/:id/movies', type: :feature do
  describe 'As a user' do
    context 'When I visit the /users/:id/movies path, where :id, is the id of a valid user' do
      it "When I navigate to this page via the search function I see the following info.", :vcr do
        @steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
    
        visit user_discover_index_path(@steve)
          fill_in :search, with: "Matrix"
          click_button "Find Movies"

        expect(page.status_code).to eq 200
        expect(page).to have_content("Vote Average: 8.2")
        expect(page).to have_content("The Matrix Reloaded")
        expect(page).to have_content("Vote Average: 7.032")
        expect(page).to_not have_content("Hot Dog")
        expect(page).to have_link("The Matrix")
        expect(page).to have_link("The Matrix Reloaded")
      end

      it "Displays the message 'Movie Results for: keyword'", :vcr do
        @steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
        visit user_discover_index_path(@steve)
        fill_in :search, with: "The Matrix"
        click_button "Find Movies"
        
        expect(page).to have_content("Movie Results for: The Matrix")
      end
    

      describe "when I click on 'Find Top Rated Movies', I am taken to movies index (/users/:user_id/movies)" do
        before do
          @steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
          visit user_discover_index_path(@steve)
          click_button "Find Top Rated Movies"
        end

        it 'I should see title (as a link to the movie details page), vote average of the movie, and only 20 results', :vcr do
          expect(page).to have_content("The Godfather")
          expect(page).to have_content(8.7)
          expect(page).to have_link("The Godfather")
        end

        it 'I should see a button to return to the Discover page', :vcr do
          expect(current_path).to eq(user_movies_path(@steve.id))
          expect(page).to have_button("Return to Discover Page")

          click_button "Return to Discover Page"
          expect(current_path).to eq(user_discover_index_path(@steve.id))
        end
      end
    end
  end
end