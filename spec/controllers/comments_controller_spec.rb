require 'spec_helper'

describe CommentsController do
  render_views

  describe "with authenticated user" do
    before(:each) do
      @user = Factory.create(:user)
      @picture = Factory.create(:picture)
      sign_in @user
    end

    describe "POST create with picture_id and valid params" do
      before(:each) do
        post :create, :picture_id => @picture.id, :comment => Factory.attributes_for(:comment)
      end
      
      it "should redirect to picture" do
        response.should redirect_to(@picture)
      end

      it "should add comment to picture" do
        @picture.comments.count.should == 1
      end

      it "should assign current_user to newly created comment" do
        @picture.comments.first.user.should == @user
      end
    end
  end

  describe "without authenticated user" do
    before(:each) do
      @picture = Factory.create(:picture);
      @comment = Factory.create(:comment);
    end
  
    it "should not be able to create a comment" do 
      lambda do
        post :create, :picture_id => @picture.id, :comment => Factory.attributes_for(:comment) 
      end.should_not change(Comment, :count)

      response.should be_redirect
    end
  end
end

