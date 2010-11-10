require 'spec_helper'

describe Comment do
  it "should have a factory" do
    comment = Factory.create(:comment)
  end

  describe "relations" do
    describe "user" do
      it "should respond to user" do
        Comment.new.should respond_to :user
      end
    end
  end
end
