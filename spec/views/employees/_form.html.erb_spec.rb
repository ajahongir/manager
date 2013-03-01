require "spec_helper"

describe "employees/_form.html.erb" do

  it "inputs" do
    employee = create :employee
    assign(:employee, employee)
    render
    # expect(rendered).to include(employee.first_name)
  end
end