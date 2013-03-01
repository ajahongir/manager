require "spec_helper"

describe "employees/index.js.erb" do

  before do 
    view.stub(:sort_column).and_return("first_name")
    view.stub(:sort_direction).and_return("asc")
  end
  
  it "render employees" do
    employee = create :employee
    assign(:employees, Employee.paginate(page: 1))
    render
    render_template(partial: "_employees", count: 1)
  end
end