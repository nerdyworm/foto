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
  describe "Instance methods" do
    describe "can_edit?" do
      it "should respond to can_edit?" do
        user = User.new
        user.should respond_to(:can_edit?)
      end
      it "should return nil if passed nil" do
        user = User.new
        user.can_edit?(nil).should == nil
      end
      it "should be true if user owns the editable" do
        user = Factory.create(:user)
        editable = mock "Editable"
        editable.should_receive(:user_id).and_return(user.id)
        user.can_edit?(editable).should == true
      end
    end
  end
end
