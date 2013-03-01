require "spec_helper"

describe EmployeesController do
  
  let(:new_employee) { build(:employee).attributes.reject{ |field, value| %w(id created_at updated_at).include?(field) } }

  context "#index" do

    it "success" do
      employee = create(:employee)
      get :index 
      assigns(:employees).should == [employee]
      response.should be_success
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
      assigns(:employee).should be_new_record
    end
    
    it {
      get :new
      response.should render_template(:new)
    }    
  end
  
  context "#edit" do
    let(:employee) { create(:employee) }

    it "success" do
      get :edit, id: employee.id
      response.should be_success
      assigns(:employee).should == employee
    end
    
    it {
      get :edit, id: employee.id
      response.should render_template(:edit)
    }
  end
  
  context "#create" do

    it "creates a new employee" do
      expect {
        post :create, employee: new_employee
      }.to change(Employee, :count).by(1)
    end

    it "render on success" do
      post :create, employee: new_employee
      response.should redirect_to :employees
    end

    it "render on fail" do
      expect{
        post :create, employee: { first_name: nil }  
      }.to change(Employee, :count).by(0)
      response.should render_template :new
    end
  end

  context "#update" do
    let(:employee) { create :employee }

    it "success" do
      expect {
        put :update, id: employee.id, employee: new_employee
        employee.reload
      }.to change(employee, :first_name)
    end

    it "render on success" do
      put :update, id: employee.id, employee: new_employee
      response.should redirect_to :employees
    end

    it "render on fail" do
      new_employee[:first_name] = nil
      put :update, id: employee.id, employee: new_employee
      response.should render_template :edit
    end

  end

  context "#destroy" do

    it "success" do
      employee = create :employee
      expect{
        xhr :delete, :destroy, id: employee
      }.to change(Employee, :count).by(-1)
    end

    it "render" do
      employee = create :employee
      xhr :delete, :destroy, id: employee, format: :js
      assigns(:employees).should == Employee.all
      response.should render_template :index, format: :js
    end
  end
end