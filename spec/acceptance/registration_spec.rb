require File.dirname(__FILE__) + '/acceptance_helper'

feature "Registration", %q{
  In order to ...
  As a ...
  I want to ...
} do

  scenario "create a new account" do
    visit "/users/sign_up"
    
    fill_in "user_email",                 :with => "test@test.com"
    fill_in "user_password",              :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    
    lambda do
      click_button "Sign up"
    end.should change(User, :count).by(1)
  end
  
  
end
