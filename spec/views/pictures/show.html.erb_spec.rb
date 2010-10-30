require 'spec_helper'

describe "pictures/show.html.erb" do
  before(:each) do
    @picture = assign(:picture, stub_model(Picture,
      :name => "Name",
      :tags => "Tags"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Tags/)
  end
end
