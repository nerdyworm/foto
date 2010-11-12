require 'spec_helper'

describe ProfilesController do

  
  before(:each) do 
    @user = Factory.create(:user)
    @profile = @user.profile
  end

  describe "without signed in user" do
    it "should not be able to edit someone elses profile" do
       pending #profile is now an embdded do in user..
    end
    
    it "should be able to show profiles" do
      get :show, :id => 420, :username => @user.username
      response.should be_success
    end
  end
  
  describe "with signed in user" do
    before(:each) do
      sign_in @user
    end
    
    it "should let me edit my own profile" do
      get :edit
      assigns(:profile).should == @user.profile
    end
  end

end
