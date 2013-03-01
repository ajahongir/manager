require "spec_helper"

describe "posts/index" do

  it "displays all the posts" do
    create :post
    create :post
    assign(:posts, Post.paginate(page: 1))
    render
    expect(rendered).to include "posts"
    render_template(partial: "_posts", count: 2)
  end
end