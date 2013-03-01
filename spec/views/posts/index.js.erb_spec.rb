require "spec_helper"

describe "posts/index.js.erb" do

  it "render posts" do
    post = create :post
    assign(:posts, Post.paginate(page: 1))
    render
    render_template(partial: "_posts", count: 1)
  end
end