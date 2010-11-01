require 'spec_helper'

describe Picture do
  it "should belong to a user" do
    picture = Picture.new
    picture.should respond_to :user
  end
end
