require 'spec_helper'

describe Profile do
  describe "Relations" do
    it "should have a user" do
      profile = Profile.new
      profile.should respond_to :user
    end
  end
  
  it "should not be able to mass assign user_id" do
    profile = Profile.new
    profile.update_attributes({:user_id => 1})
    profile.user_id.should be nil
  end
end
