require "spec_helper"

describe "employees/_employees.html.erb" do
  
  before do 
    view.stub(:sort_column).and_return("first_name")
    view.stub(:sort_direction).and_return("asc")
  end
  
  it "list employees" do
    employee = create :employee
    assign(:employees, Employee.paginate(page: 1))
    render
    expect(rendered).to include(employee.first_name)
  end
end