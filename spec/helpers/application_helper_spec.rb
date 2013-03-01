require 'spec_helper'
describe ApplicationHelper do
  
  describe "#sortable" do

    before do
      @helper = Object.new.extend ApplicationHelper
      @column = "first_name"
      direction = "asc"
      params = {}

      @helper.stub!(:sort_column).and_return(@column)
      @helper.stub!(:params).and_return(params)
      @helper.stub!(:url_for).and_return(Proc.new{ })
      @helper.stub!(:sort_direction).and_return(direction)
    end

    it{
      @helper.sortable(@column).should include(@column.titleize)
    }
  end

  describe "#active_page" do
    it {
      expect(helper.active_page(controller)).to be_nil

      controller = "some_controller"
      params = { controller: controller}
      helper.stub!(:params).and_return(params)
      expect(helper.active_page(controller)).to eq("active")
    }
  end
end