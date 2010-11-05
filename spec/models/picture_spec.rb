require 'spec_helper'

describe Picture do
  it "should belong to a user" do
    picture = Picture.new
    picture.should respond_to :user
  end
  
  describe "relations" do
    describe "tags" do
      it "should respond to tags" do
        Picture.new.should respond_to :tags
      end

      it "should do things with tags_s" do
        cakes   = Factory.create(:tag, :name => "cakes")
        cookies = Factory.create(:tag, :name => "cookies")

        picture = Factory.create(:picture, :tags_s => "cookies, cakes")

        picture.tags.should include cakes
        picture.tags.should include cookies
      end

      it "should only create one tag" do
        picture = Factory.create(:picture)
        picture.tags_s = "cookies, cookies"
        picture.tags.size.should == 1
      end

      it "should clear exisiting tags when setting with tags_s" do
        cookies = Factory.create(:tag, :name => "cookies")

        picture = Factory.create(:picture, :tags_s => "cookies")
        picture.tags_s = ""

        picture.tags.should_not include cookies
      end
    end
  end

  describe "class methods" do
    describe "user" do
      it "should respond to user" do
        Picture.should respond_to(:user)
      end
      
      it "should return all pictures by user" do
        user = Factory.create(:user)
        find_me = Factory.create(:picture, :user => user)
        not_me  = Factory.create(:picture)

        Picture.user(user.id).should include find_me
        Picture.user(user.id).should_not include not_me
      end
    end
  end
  
  describe "scopes" do
    describe "public" do
      it "should respond to public" do
        Picture.should respond_to(:public)
      end

      it "should return only public pictures" do
        pub = Factory.create(:picture, :private => false)
        pri = Factory.create(:picture, :private => true)
        Picture.public.all.should include pub
        Picture.public.all.should_not include pri
      end
    end
  end
end
