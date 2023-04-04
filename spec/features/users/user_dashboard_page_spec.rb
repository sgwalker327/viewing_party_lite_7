require 'rails_helper'


RSpec.describe '/users/:id', type: :feature do
  before do
    @steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
    @bob = User.create!(name: "bob", email: "bob@bob.com", password: "password")
    @meg = User.create!(name: "meg", email: "meg@meg.com", password: "password")
    @fran = User.create!(name: "fran", email: "fran@fran.com", password: "password")
    visit "/users/#{@steve.id}"
  end

  describe 'When a user visits their dashboard' do
    it "shows the 'user dashboard' header" do
      expect(page).to have_content("#{@steve.name}'s Dashboard")
    end

    it "has a button to discover movies" do
      expect(page).to have_link("Discover Movies")
      expect(page).to have_content("Lists of viewing parties")
    end

    it "when I click the discover movies button, I am redirected to the discover movies page (/users/:id/discover), where the :id is the user dashboard I was just on" do
      click_link "Discover Movies"
      expect(current_path).to eq(user_discover_index_path(@steve.id))
    end
  end

  describe "when a user creates a viewing party and are taken back to their dashboard" do
    it "shows the viewing party just created on their dashboard", :vcr do
      visit "/users/#{@steve.id}/movies/238/viewing_party/new"

      fill_in :duration, with: "185"
      fill_in :date, with: "03/27/2023"
      fill_in :time, with: "03:00 PM"
      check "bob"
      check "meg"
      
      click_on "Create Party"
      
      expect(current_path).to eq(user_path(@steve))
      
    end
  end
end