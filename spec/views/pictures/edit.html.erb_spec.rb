require 'spec_helper'

describe "pictures/edit.html.erb" do
  before(:each) do
    @picture = assign(:picture, stub_model(Picture,
      :new_record? => false,
      :name => "MyString",
      :tags => "MyString"
    ))
  end

  it "renders the edit picture form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => picture_path(@picture), :method => "post" do
      assert_select "input#picture_name", :name => "picture[name]"
      assert_select "input#picture_tags", :name => "picture[tags]"
    end
  end
end
