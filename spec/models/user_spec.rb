require 'spec_helper'

describe User do
  describe "Factory" do
    it "should have a factory" do
      user = Factory.create(:user)
      user.id.should_not be nil
    end
  end
  
  describe "Relations" do
    describe "pictures" do
      it "should have many pictures" do
        user = User.new
        user.should respond_to :pictures
      end
    end
  end

  describe "Instance methods" do
    describe "can_edit?" do
      it "should respond to can_edit?" do
        user = User.new
        user.should respond_to(:can_edit?)
      end
      
      it "should be false if passed nil" do     user = User.new
        user.can_edit?(nil).should == false 
      end

      it "should be false if user does not own the editable" do
        user = Factory.create(:user)
        editable = mock "Editable"
        editable.should_receive(:user).and_return(-1)
        user.can_edit?(editable).should == false
      end
      
      it "should be true if user owns the editable" do
        user = Factory.create(:user)
        editable = mock "Editable"
        editable.should_receive(:user).and_return(user)
        user.can_edit?(editable).should == true
      end

      it "should be true if user is an admin" do
        user = Factory.create(:user, :admin => true)
        editable = mock "Editable"
        editable.should_receive(:user).and_return(nil)
        user.can_edit?(editable).should == true
      end
    end

    describe "admin?" do
      it "should respond to admin?" do
        user = User.new
        user.should respond_to(:admin?)
      end
      
      it "should default to false" do
        user = Factory.create(:user)
        user.admin?.should == false
      end
      
      it "should not be able to mass assign admin" do
        user = User.new
        user.update_attributes({:admin => true})
        user.admin?.should == false
      end
    end
  end
end
