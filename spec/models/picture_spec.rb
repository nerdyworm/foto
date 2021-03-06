require 'spec_helper'

describe Picture do 
  it "should belong to a user" do
    picture = Picture.new
    picture.should respond_to :user
  end
  
  describe "relations" do
    describe "feedbacks" do
      it "should respond to feedbackss" do
        Picture.new.should respond_to :feedbacks
      end
    end

    describe "tags" do
      it "should respond to tags" do
        Picture.new.should respond_to :tags
      end
      
      it "should take a list of tags" do
        picture = Factory.create(:picture)

        picture.tags = ["one", "two"]

        picture.tags.should include "one"
        picture.tags.should include "two"
      end

      it "should remove tags from all pictures" do
        picture = Factory.create(:picture, :tags => ["remove", "tag"])
        picture2= Factory.create(:picture, :tags => ["remove", "tag"])

        Picture.remove_tag("remove")

        picture.reload
        picture2.reload

        picture.tags.should_not include "remove"
        picture2.tags.should_not include "remove"
      end
    end
  end

  describe "class methods" do
    describe "user" do
      it "should respond to by_user_id" do
        Picture.should respond_to(:find_by_user_id)
      end
      
      it "should return all pictures by user" do
        user = Factory.create(:user)
        find_me = Factory.create(:picture, :user => user)
        not_me  = Factory.create(:picture)

        Picture.find_by_user_id(user.id).should include find_me
        Picture.find_by_user_id(user.id).should_not include not_me
      end
    end

    describe "vote" do
      it "should respond to vote" do
        Picture.should respond_to(:vote)
      end

    describe "upvote" do
      it "should respond to upvote" do
        Picture.should respond_to(:upvote)
      end

      it "should increment votes by one if user has not voted" do
        user = Factory.create(:user)
        picture = Factory.create(:picture)
        
        Picture.upvote(picture.id, user.id.to_s)
        Picture.upvote(picture.id, user.id.to_s)
        picture.reload
        picture.votes.should == 1
      end
    end

      describe "downvote" do
        it "should respond to downvote" do
          Picture.should respond_to :downvote
        end

        it "should decrement votes by one if user has not voted" do
          user = Factory.create(:user)
          picture = Factory.create(:picture)

          Picture.downvote(picture.id, user.id.to_s)
          Picture.downvote(picture.id, user.id.to_s)

          picture.reload
          picture.votes.should == -1
        end
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
