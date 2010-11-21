require 'spec_helper'

describe Tag do

  it "should remove all references from picture when destroyed" do
    tag     = Factory.create(:tag, :name => "tag")
    picture = Factory.create(:picture, :tags => ["tag", "tags"])

    tag.destroy
    picture.reload

    picture.tags.should include "tags"
    picture.tags.should_not include "tag"
  end
end
