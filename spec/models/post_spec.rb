require "spec_helper"

describe Post do

  let(:cant_ba_blank) { "can't be blank" }
  let(:has_already_been_taken) { "has already been taken" }
  let(:post) { build(:post) }

  subject { build(:post) }

  it { should respond_to :name }
  it { should respond_to :employees }

  context "valid params" do
    it { should be_valid }
    its(:save){ should be_true }
  end

  context "no params" do
    it "not allow nil " do
      post.name = nil
      post.should_not be_valid 
      post.errors_on(:name).should include(cant_ba_blank)
      
      post.name = " "
      post.errors_on(:name).should include(cant_ba_blank)
    end
  end

  context "invalid params" do
    before { post.name = " " }

    specify { post.errors_on(:name).should include(cant_ba_blank) } 
  end

  context "association" do
    it{
      p = Post.reflect_on_association(:employees)
      p.macro.should == :has_many  
    }
    
  end
  context "#busy?" do

    it "not busy busy while have no employees" do
      post = create(:post)
      
      post.employees.should be_empty
      post.busy?.should be_false
    end

    it "busy while have employees" do
      employee = create(:employee)

      post = employee.post
      post.attributes.has_key?(:busy).should be_false
      post.busy?.should be_true
      
      employee.destroy
      post.busy?.should be_false
    end

  end

  context "#removable" do
    let(:posts) { Post.removable }

    it { posts.should be_empty }
    it "should have busy attribute" do
      create(:post)
      create(:post)
      posts.should_not be_empty
      posts.each { |post| post.attributes.has_key?("busy").should be_true }
    end

  end

end