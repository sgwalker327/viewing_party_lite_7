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

    # it "I should see a list of users that are links to their dashboards" do
    #   expect(page).to have_content(@steve.name)
    #   expect(page).to have_link("steve", :href => "/users/#{@steve.id}")
    # end

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

  describe 'As a logged in user' do
    context 'When I visit the landing page' do
      it 'I no longer see a login link or a create user link' do
        @sam = User.create!(name: "sam", email: "sam@steve.com", password: "password")
        visit login_path
        fill_in 'email', with: @sam.email
        fill_in 'password', with: @sam.password

        click_button("Log In")
        expect(current_path).to eq(user_path(@sam.id))

        click_link("Landing Page")

        expect(current_path).to eq('/')
        expect(page).to have_link("Log Out", :href => "/logout")
        expect(page).to_not have_link("Log In")
        expect(page).to_not have_link("Create New User", :href => "/users/new")
      end

      it 'When I click the logout link, I am redirected to the landing page and I see a login link' do
        @sam = User.create!(name: "sam", email: "sam@steve.com", password: "password")
        visit login_path
        fill_in 'email', with: @sam.email
        fill_in 'password', with: @sam.password

        click_button("Log In")
        expect(current_path).to eq(user_path(@sam.id))

        click_link("Landing Page")
        expect(current_path).to eq("/")

        click_link("Log Out")

        expect(current_path).to eq("/")
        expect(page).to have_link("Log In", :href => "/login")
        expect(page).to have_link("Create New User", :href => "/users/new")
      end
    end
  end

  describe 'As a visitor' do
    context 'When I visit the landing page' do
      it 'I do not see the section of the page that lists existing users' do
        visit '/'

        expect(page).to_not have_content("Existing Users")
      end
    end
  end
end