require 'rails_helper'

RSpec.describe 'New Viewing Party Page' do
  before do
    @steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
    @bob = User.create!(name: "bob", email: "bob@bob.com", password: "password")
    @meg = User.create!(name: "meg", email: "meg@meg.com", password: "password")
    @fran = User.create!(name: "fran", email: "fran@fran.com", password: "password")
  end

  describe "when I visit '/users/:id/movies/:movie_id/viewing_party/new'" do
    it 'I should see the name of the movie title rendered above a form', :vcr do
      visit "/users/#{@steve.id}/movies/238/viewing_party/new"
      
      expect(page).to have_content("The Godfather")
    end

    it "should have a form with the following fields: duration of party, when, start time, checkboxes next to each existing user, and a button to creat a party", :vcr do
      visit "/users/#{@steve.id}/movies/238/viewing_party/new"
      
      expect(page).to have_content("Viewing Party Details")
      expect(page).to have_content("Movie Title: The Godfather")
      expect(page).to have_field(:duration)
      expect(page).to have_field("Duration of Party", with: "175")

      expect(page).to have_field(:date)
      expect(page).to have_field(:time)
      expect(page).to have_unchecked_field("bob")
      expect(page).to have_unchecked_field("meg")
      expect(page).to have_button("Create Party")
    end
  end

  context "when the form is filled in and Create party is clicked" do
    it "redirects me to the user dashboard", :vcr do
      visit "/users/#{@steve.id}/movies/238/viewing_party/new"

      fill_in :duration, with: "185"
      fill_in :date, with: "03/25/2023"
      fill_in :time, with: "02:00 PM"
      check "bob"
      check "meg"
      check "fran"
      
      click_on "Create Party"

      expect(current_path).to eq(user_path(@steve))
    end
  end

  context "when the form is filled in with a shorter duration than movie run time" do
    it "the party is not created and the user is redirected back to the new party form", :vcr do
      visit "/users/#{@steve.id}/movies/238/viewing_party/new"

      fill_in :duration, with: "60"
      fill_in :date, with: "03/25/2023"
      fill_in :time, with: "02:00 PM"
      check "bob"
      check "meg"
      check "fran"

      click_on "Create Party"
      
      expect(current_path).to eq(new_user_movie_viewing_party_path(@steve, 238))
    end
  end
end