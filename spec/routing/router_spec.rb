require 'spec_helper'

describe "routing to posts" do
  
  context "actions" do
    it{
      expect(get: "/posts").
        to route_to("posts#index")  
    }
     
    it{
      expect(get: "/posts/new").
        to route_to("posts#new")  
    }
        
    it{
      expect(get: "/posts/1/edit").to route_to(
        controller: "posts",
        action: "edit",
        id: "1")  
    }

    it{
      expect(post: "/posts").
        to route_to("posts#create")
    }
    
    it{
      expect(put: "/posts/1").to route_to(
        controller: "posts",
        action: "update",
        id: "1")  
    }
    
    it {
      { get: '/posts/1' }.should_not be_routable  
    }
    
    it {
      expect(delete: '/posts/1').to route_to(
        controller: "posts",
        action: "destroy",
        id: "1")
    }
  end
  
end

describe "routing to employees" do 
  
  context "root path" do
    it{
      expect(get("/")).to route_to("employees#index")
    }
  end

  context "actions" do
    it{
      expect(get: "/employees").
        to route_to("employees#index")  
    }
     
    it{
      expect(get: "/employees/new").
        to route_to("employees#new")  
    }
        
    it{
      expect(get: "/employees/1/edit").to route_to(
        controller: "employees",
        action: "edit",
        id: "1")  
    }

    it{
      expect(post: "/employees").
        to route_to("employees#create")
    }
    
    it{
      expect(put: "/employees/1").to route_to(
        controller: "employees",
        action: "update",
        id: "1")  
    }
    
    it {
      { get: '/employees/1' }.should_not be_routable  
    }
    
    it {
      expect(delete: '/employees/1').to route_to(
        controller: "employees",
        action: "destroy",
        id: "1")
    }
  end

end