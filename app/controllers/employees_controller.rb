class EmployeesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    get_employees
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      redirect_to :employees, notice: t("controllers.employees.flash.create")
    else
      render action: "new"
    end
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      redirect_to :employees, notice: t("controllers.employees.flash.update")
    else
      render action: "edit"
    end
  end

  def destroy
    Employee.delete(params[:id])
    flash[:notice] = t("controllers.employees.flash.delete")
    get_employees
    render :index 
  end


private
  
  def sort_column
    Employee.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def get_employees
    @employees = Employee.filter_status(params).search(params).sort(sort_column, sort_direction).paginate(page: params[:page])
  end
end
