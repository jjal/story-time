require 'spec_helper'

describe "ratings/show" do
  before(:each) do
    @rating = assign(:rating, stub_model(Rating,
      :user_id => 1,
      :story_id => 2,
      :score => 3,
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Comment/)
  end
end
