require "spec_helper"

describe "employees/edit.html.erb" do

  it "edit" do
    employee = create :employee
    assign(:employee, employee)
    render
    render_template(partial: "_form", count: 1)
  end
end