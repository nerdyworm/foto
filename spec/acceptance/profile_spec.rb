require File.dirname(__FILE__) + '/acceptance_helper'

feature "Profile" do

  scenario "view my public profile" do
    visit "/profile"
  end
  
end
