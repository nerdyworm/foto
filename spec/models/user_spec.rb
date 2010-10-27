require 'spec_helper'

describe User do
  describe "Factory" do
    it "should have a factory" do
      user = Factory.create(:user)
      user.id.should_not be nil
    end
  end
  
  describe "Relations" do
    it "should have a profile" do
      user = User.new
      user.should respond_to :profile
    end
    
    it "should create a profile when created" do
      user = Factory.create(:user)
      user.profile.id.should_not be nil
    end
  end
end
