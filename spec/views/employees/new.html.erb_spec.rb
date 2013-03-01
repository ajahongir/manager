require "spec_helper"

describe "employees/new.html.erb" do

  it "displays all the employees" do
    employee = build :employee
    assign(:employee, employee)
    render
    render_template(partial: "_form", count: 1)
  end
end