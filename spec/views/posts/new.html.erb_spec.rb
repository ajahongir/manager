require "spec_helper"

describe "posts/new" do

  it "displays all the posts" do
    post = build :post
    assign(:post, post)
    render
    render_template(partial: "_form", count: 1)
  end
end