require 'spec_helper'

describe PicturesController do

  def mock_picture(stubs={})
    (@mock_picture ||= mock_model(Picture).as_null_object).tap do |picture|
      picture.stub(stubs) unless stubs.empty?
    end
  end

  describe "with authenticated user" do
    before(:each) do
      @user = Factory.create(:user)
      sign_in @user
    end
    
    it "should be able to view the new picture" do
      pending #tanya  interupted
    end
  end
  
  describe "without authenticated user" do
    
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  describe "GET index" do
    it "assigns all pictures as @pictures" do
      Picture.stub(:all) { [mock_picture] }
      get :index
      assigns(:pictures).should eq([mock_picture])
    end
  end

  describe "GET show" do
    it "assigns the requested picture as @picture" do
      Picture.stub(:find).with("37") { mock_picture }
      get :show, :id => "37"
      assigns(:picture).should be(mock_picture)
    end
  end

  describe "GET new" do
    it "assigns a new picture as @picture" do
      Picture.stub(:new) { mock_picture }
      get :new
      assigns(:picture).should be(mock_picture)
    end
  end

  describe "GET edit" do
    it "assigns the requested picture as @picture" do
      Picture.stub(:find).with("37") { mock_picture }
      get :edit, :id => "37"
      assigns(:picture).should be(mock_picture)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created picture as @picture" do
        Picture.stub(:new).with({'these' => 'params'}) { mock_picture(:save => true) }
        post :create, :picture => {'these' => 'params'}
        assigns(:picture).should be(mock_picture)
      end

      it "redirects to the created picture" do
        Picture.stub(:new) { mock_picture(:save => true) }
        post :create, :picture => {}
        response.should redirect_to(picture_url(mock_picture))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved picture as @picture" do
        Picture.stub(:new).with({'these' => 'params'}) { mock_picture(:save => false) }
        post :create, :picture => {'these' => 'params'}
        assigns(:picture).should be(mock_picture)
      end

      it "re-renders the 'new' template" do
        Picture.stub(:new) { mock_picture(:save => false) }
        post :create, :picture => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested picture" do
        Picture.should_receive(:find).with("37") { mock_picture }
        mock_picture.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :picture => {'these' => 'params'}
      end

      it "assigns the requested picture as @picture" do
        Picture.stub(:find) { mock_picture(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:picture).should be(mock_picture)
      end

      it "redirects to the picture" do
        Picture.stub(:find) { mock_picture(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(picture_url(mock_picture))
      end
    end

    describe "with invalid params" do
      it "assigns the picture as @picture" do
        Picture.stub(:find) { mock_picture(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:picture).should be(mock_picture)
      end

      it "re-renders the 'edit' template" do
        Picture.stub(:find) { mock_picture(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested picture" do
      Picture.should_receive(:find).with("37") { mock_picture }
      mock_picture.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the pictures list" do
      Picture.stub(:find) { mock_picture }
      delete :destroy, :id => "1"
      response.should redirect_to(pictures_url)
    end
  end

end
