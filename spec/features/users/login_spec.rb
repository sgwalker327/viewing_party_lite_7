require 'rails_helper'

RSpec.describe '/login page', type: :feature do
  describe 'As a registered user' do
    describe 'When I visit the login page' do
      it 'I see a field to enter my email address and password' do
        visit login_path
        expect(page).to have_field(:email)
        expect(page).to have_field(:password)
      end

      it 'when I fill in my email and password and click submit, I am redirected to my dashboard' do
        steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")

        visit login_path

        fill_in :email, with: steve.email
        fill_in :password, with: steve.password

        click_button "Log In"

        expect(current_path).to eq(user_path(steve.id))
      end

      it 'when I fill in my email and an incorrect password and click submit, I am redirected to the login page' do
        steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")

        visit login_path

        fill_in :email, with: steve.email
        fill_in :password, with: "assword"

        click_button "Log In"

        expect(current_path).to eq(login_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end