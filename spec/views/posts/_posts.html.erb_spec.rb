require "spec_helper"

describe "posts/_posts" do

  it "list posts" do
    post = create :post, name: "Sam"
    assign(:posts, Post.paginate(page: 1))
    render
    expect(rendered).to match /Sam/
  end
end