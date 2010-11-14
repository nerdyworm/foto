require 'spec_helper'

describe Feedback do

  describe "votes" do

    before(:each) do 
      @user = Factory.create(:user)
      @user2 = Factory.create(:user)
      @picture = Factory.create(:picture, 
        :feedbacks => [ Factory.create(:feedback)])
      @id = @picture.feedbacks.first.id
    end

    it "should vote up if user has not voted" do
      Feedback.upvote(@id, @user.id)
      Feedback.upvote(@id, @user.id)

      @picture.reload
      @picture.feedbacks.first.votes.should == 1

      Feedback.upvote(@id, @user2.id)

      @picture.reload
      @picture.feedbacks.first.votes.should == 2
    end

    it "should vote do if user has note voted" do
      Feedback.downvote(@id, @user.id)
      Feedback.downvote(@id, @user.id)

      @picture.reload
      @picture.feedbacks.first.votes.should == -1
    end
  end
end
