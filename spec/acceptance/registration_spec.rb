require File.dirname(__FILE__) + '/acceptance_helper'

feature "Registration", %q{
  In order to ...
  As a ...
  I want to ...
} do

  scenario "create a new account" do
    lambda do
      complete_signup
    end.should change(User, :count).by(1)
  end
  
  
  scenario "after i create a new accoutn i should see my profile" do
    complete_signup
    
    page.should have_content('Profile')
  end
  
  def complete_signup
    visit "/users/sign_up"
    
    fill_in "user_email",                 :with => "test@test.com"
    fill_in "user_password",              :with => "password"
    fill_in "user_password_confirmation", :with => "password"
    click_button "Sign up"
  end
  
end
