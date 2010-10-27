require 'spec_helper'

describe Profile do
  describe "Relations" do
    it "should have a user" do
      profile = Profile.new
      profile.should respond_to :user
    end
  end
end
