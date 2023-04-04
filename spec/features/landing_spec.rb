require 'rails_helper'

RSpec.describe '/', type: :feature do
  
  before do
  @steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
    visit '/'
  end

  describe "When a user visit's the landing page" do
    it "I should see the title of the Application" do
      expect(page).to have_content("Viewing Party")
    end

    it "I should see a button to the user new page" do
      expect(page).to have_link("Create New User", :href => "/users/new")
    end

    it "I should see a list of users that are links to their dashboards" do
      expect(page).to have_content(@steve.name)
      expect(page).to have_link("steve", :href => "/users/#{@steve.id}")
    end

    it "I should see a link that returns me to the landing page" do
      expect(page).to have_link("Landing Page", :href => "/")
    end

    it "I should see a link to the login page" do
      expect(page).to have_link("Log In", :href => "/login")
    end

    it "When I click the link to the login page, I am redirected to the login page" do
      click_link "Log In"
      expect(current_path).to eq("/login")
    end
  end
end