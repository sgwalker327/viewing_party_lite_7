require 'rails_helper'

RSpec.describe '/register', type: :feature do
  before do
    @steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
    visit '/register'
  end
  describe "When a user visits the registration page" do
    it 'should have a form to register' do
      expect(page).to have_content("Register User")
      expect(page).to have_field(:name)
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
      expect(page).to have_field(:password_confirmation)
    end

    it "should fill in form, click submit, and be redirected to dashboard ('/users/:id'), where id was the user.id just created" do
      fill_in :name, with: "Larry"
      fill_in :email, with: "Larry@yahoo.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_button "Submit"
  
      expect(current_path).to eq("/users/#{User.last.id}")
      expect(page).to have_content("User was successfully created")
    end
    
    describe 'sad path for user registration' do
      it "should not create a user if any info is not filled in correctly" do
        fill_in :name, with: "Katie"
        fill_in :email, with: "katie@katie.com"
        fill_in :password, with: "password"
        fill_in :password_confirmation, with: "password1"

        click_button "Submit"

        expect(current_path).to eq("/register")
      end

      it "should not create a user if the passwords do not match" do
        fill_in :name, with: "Katie"
        fill_in :email, with: "katie@katie.com"
        fill_in :password, with: "password"
        fill_in :password_confirmation, with: ""

        click_button "Submit"

        expect(current_path).to eq("/register")
      end

      it "should not create a user if email is not unique " do
        fill_in :name, with: "Katie"
        fill_in :email, with: "steve@steve.com"
        click_button "Submit"

        expect(current_path).to eq("/register")
        expect(page).to have_content("Info is not valid" )
      end
    end
  end
end