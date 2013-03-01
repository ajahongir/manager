require "spec_helper"

describe "posts/_form" do

  it "inputs" do
    post = create :post, name: "Sam"
    assign(:post, post)
    render
    expect(rendered).to match /Sam/
    expect(rendered).to match /form/
  end
end