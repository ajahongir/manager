require "spec_helper"

describe "posts/edit" do

  it "edit" do
    post = create :post, name: "Sam"
    assign(:post, post)
    render
    expect(rendered).to include(post.name)
    render_template(partial: "_form", count: 1)
  end
end