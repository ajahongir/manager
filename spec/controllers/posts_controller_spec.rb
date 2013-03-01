require "spec_helper"

describe PostsController do

  let(:new_post) { build(:post).attributes.reject{ |field, value| %w(id created_at updated_at).include?(field) } }    

  context "#index" do

    it "success" do
      post = create(:post)
      get :index 
      assigns(:posts).should == [post]
    end

    it {
      get :index
      response.should be_success
      response.should render_template(:index, format: :html)
    }

    it {
      xhr :get, :index, format: :js
      response.should render_template(:index, format: :js)
    }
  end
  
  context "#new" do
    
    it "success" do
      get :new 
      response.should be_success
      assigns(:post).should be_new_record
    end
    
    it {
      get :new
      response.should render_template(:new)
    }    
  end
  
  context "#edit" do
    let(:post) { create(:post) }

    it "success" do
      get :edit, id: post.id
      response.should be_success
      assigns(:post).should == post
    end
    
    it {
      get :edit, id: post.id
      response.should render_template(:edit)
    }
  end
  
  context "#create" do

    it "creates a new post" do
      expect {
        post :create, post: new_post
      }.to change(Post, :count).by(1)
    end

    it "render on success" do
      post :create, post: new_post  
      response.should redirect_to :posts
    end

    it "render on fail" do
      expect{
        post :create, post: { name: nil }  
      }.to change(Post, :count).by(0)
      response.should render_template :new
    end
  end

  context "#update" do
    let(:post) { create :post }

    it "success" do
      expect {
        put :update, id: post, post: new_post
        post.reload
      }.to change(post, :name)
    end

    it "render on success" do
      put :update, id: post, post: new_post
      response.should redirect_to :posts
    end

    it "render on fail" do
      new_post[:name] = nil
      put :update, id: post, post: new_post
      response.should render_template :edit
    end

  end

  context "#destroy" do

    it "not busy" do
      post = create :post
      expect{
        post.busy?.should be_false
        xhr :delete, :destroy, id: post
      }.to change(Post, :count).by(-1)
    end

    it "busy" do
      employee = create :employee
      busy_post = employee.post
      busy_post.busy?.should be_true

      expect{
        xhr :delete, :destroy, id: busy_post
      }.to_not change(Post, :count)
    end

    it "render" do
      post = create :post
      xhr :delete, :destroy, id: post.id
      assigns(:posts).should == Post.all
      response.should render_template :index, format: :js
    end
  end

end