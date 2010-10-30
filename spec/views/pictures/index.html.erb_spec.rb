require 'spec_helper'

describe "pictures/index.html.erb" do
  before(:each) do
    assign(:pictures, [
      stub_model(Picture,
        :name => "Name",
        :tags => "Tags"
      ),
      stub_model(Picture,
        :name => "Name",
        :tags => "Tags"
      )
    ])
  end

  it "renders a list of pictures" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
  end
end
