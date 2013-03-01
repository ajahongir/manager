require "spec_helper"

describe Employee do

  let(:cant_ba_blank) { "can't be blank" }
  let(:has_already_been_taken) { "has already been taken" }
  let(:this_name_taken) { "This name is already taken" }
  let(:employee) { build(:employee) }

  subject { build(:employee) }

  it { should respond_to :first_name }
  it { should respond_to :last_name }
  it { should respond_to :phone }
  it { should respond_to :status }
  it { should respond_to :post_id }
  it { should respond_to :post }
  it { should respond_to :name }

  context "valid params" do
    it { should be_valid }
    its(:save){ should be_true }
  end

  context "no params" do
  
    it "not allow nil " do
      employee.first_name = nil
      employee.should_not be_valid 
      employee.errors_on(:first_name).should include(cant_ba_blank)
      
      employee.first_name = " "
      employee.errors_on(:first_name).should include(cant_ba_blank)
    end

    it "post presence" do
      employee.post_id = nil
      employee.should_not be_valid
      employee.should have(1).errors_on(:post)
    end

    it "uniqness" do
      create(:employee, first_name: "Sam", last_name: "Sam")
      employee = build(:employee, first_name: "Sam", last_name: "Sam")
      employee.save.should_not be_true
      employee.should have(1).errors_on(:first_name)
      employee.errors_on(:first_name).should include(this_name_taken)

      employee = build(:employee, first_name: "Sam")
      employee.should be_valid
    end

  end

  context "association" do
    it {
      e = Employee.reflect_on_association(:post)
      e.macro.should == :belongs_to
    }
  end

  context "#sort" do
    before { 5.times { create(:employee) } }

    let(:fields) { %w(first_name last_name phone) }
    let(:directions) { %w(asc desc) }

    it "order by fields" do 
      fields.each{ |field| check_sort(field, directions.first) }
      fields.each{ |field| check_sort(field, directions.last) }
    end

    it "order by post" do 
      directions.each{ |direction| check_sort('post_id', directions) }
    end

    def check_sort(field, direction)
      if field == 'post_id'
        Employee.sort(field, direction).should == Employee.joins(:post).order("posts.name #{ direction }")
      else
        Employee.sort(field,direction).should == Employee.order("#{ field} #{ direction }")
      end
    end
  end

  context "#filter_status" do
    it {
      check_status_filter({ status: true })
      check_status_filter({ status: false })
    }

    it { Employee.filter_status({status: nil }).should == Employee.all }

    def check_status_filter(options)
      employees =  Employee.filter_status(options)
      employees.each {|e| e.status.should == options[:status] }
    end
  end

  context "#search" do
    before { create(:employee, first_name: "Mike", last_name: "Jackson") }
    
    it "find by first_and last name" do 
      check_search({ search: "Mi" })
      check_search({ search: "ackso" })
    end

    it { Employee.search({ search: " " }).should == Employee.all  }
      
    def check_search(options)
      employees =  Employee.search(options)
      employees.each { |e| (e.first_name.include?(options[:search]) || e.last_name.include?(options[:search])).should be_true }
    end

    context "#name" do

      it "setter" do 
        employee = Employee.new name: "Some Name"
        employee.first_name.should eq("Some")
        employee.last_name.should eq("Name")
      end

    end
  end

end