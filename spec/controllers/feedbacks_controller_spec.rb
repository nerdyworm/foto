require 'spec_helper'

describe FeedbacksController do
  render_views

  describe "with authenticated user" do
    before(:each) do
      @user = Factory.create(:user, :username => "lolcats")
      @picture = Factory.create(:picture)
      sign_in @user
    end
 
    describe "POST create with picture_id and valid params" do
      before(:each) do
        post :create, :picture_id => @picture.id, :feedback => Factory.attributes_for(:feedback)
      end
      
      it "should assign @picture" do
        assigns(:picture).id.should == @picture.id
      end
      
      it "should redirect to picture" do
        response.should redirect_to assigns(:picture)
      end

      it "should add feedback to picture" do
        assigns(:picture).feedbacks.count.should == 1
      end

      it "should assign current_user.username to newly created feedback" do
        assigns(:picture).feedbacks.first.username.should == @user.username 
      end
    end
  end

  describe "without authenticated user" do
    before(:each) do
      @picture = Factory.create(:picture);
    end
  
    it "should not be able to create a feedback" do 
      lambda do
        post :create, :picture_id => @picture.id, :feedback => Factory.attributes_for(:feedback) 
      end.should_not change(@picture.reload.feedbacks, :count)

      response.should be_redirect
    end
  end
end

