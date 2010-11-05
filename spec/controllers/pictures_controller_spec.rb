require 'spec_helper'

describe PicturesController do
  render_views

  describe "with authenticated user" do
    before(:each) do
      @user = Factory.create(:user)
      sign_in @user
    end
    
    it "should be able to view new picture" do
      get :new
      response.should be_success
    end
    
    it "should be able to create a new picture" do
      lambda do
        post :create, :picture => Factory.attributes_for(:picture)
      end.should change(Picture, :count).by(1)
    end
    
    it "should assign the current user to the new picture" do
      post :create, :picture => Factory.attributes_for(:picture)
      picture = assigns(:picture)
      picture.user.should == @user
    end
    
    it "should be able to edit pictures that belong to them" do 
      picture = Factory.create(:picture, :user => @user)
      get :edit, :id => picture.id
      response.should be_success
    end
    
    it "should not be able to edit other's pictures" do
      not_mine = Factory.create(:picture, :user => Factory.create(:user))
      
      get :edit, :id => not_mine.id
      response.should redirect_to(user_profile_path)
      
      put :update, :id => not_mine.id, :picture => {:name => "new name"}
      response.should redirect_to(user_profile_path)
    end
  end

  describe "with user_id paramter" do
    it "should list all the user_id's public pictures" do
      user = Factory.create(:user)
      mine = Factory.create(:picture, :user_id => user.id, :private => false)
      p_mine = Factory.create(:picture, :user_id => user.id, :private => true)
      not_mine = Factory.create(:picture, :user_id => user.id + 1)

      get :index, :user_id => user.id
      assigns(:pictures).should include mine
      assigns(:pictures).should_not include p_mine
      assigns(:pictures).should_not include not_mine
    end
  end
  
  describe "without authenticated user" do
    it "should NOT be able to view new picture" do
      get :new
      response.should be_redirect
    end
    
    it "should NOT be able to create a new picture" do
      lambda do
        post :create, :picture => Factory.attributes_for(:picture)
      end.should_not change(Picture, :count).by(1)
    end
    
    it "should NOT be able to edit other's pictures" do
      not_mine = Factory.create(:picture, :user => Factory.create(:user))
      
      get :edit, :id => not_mine.id
      response.should be_redirect
    end
    
    it "should NOT be able to view private pictures" do
      private_picture = Factory.create(:picture, :private => true)
      
      get :show, :id => private_picture.id
      response.response_code.should == 404
    end

    it "should be able to view by tag" do
      tag = "tag"
      me = Factory.create(:picture, :private => false, 
                          :tags => [Factory.create(:tag, :name => tag)])
      
      not_me = Factory.create(:picture, :private => false, 
                          :tags => [Factory.create(:tag, :name => "no tag")])
      
      get :tags, :tag => tag
      response.should be_success
      assigns(:pictures).should include me
      assigns(:pictures).should_not include not_me 
    end
  end
end
