require 'spec_helper'

describe Tag do

  it "should create a new tag when does not exist" do
    exists = Factory.create(:tag, :name => "tag 1")

    lambda do
      t = Tag.find_or_create_by_name("tag 1")
    end.should_not change(Tag, :count)

    lambda do
      t = Tag.find_or_create_by_name("tag new")
    end.should change(Tag, :count)
  end

end 
