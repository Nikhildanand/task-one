class AdminController < ApplicationController
  def login
  end

  def dashboard
    redirect_to root_url unless logged_in?
  end

  def employee
    redirect_to root_url unless logged_in?
  end
  
  def add_employee
    redirect_to root_url unless logged_in?
    @employee = Employee.new
  end
  
  def employee_details
    redirect_to root_url unless logged_in?
    @empdtail = Employee.find(params[:id])
  end

  def projects
    redirect_to root_url unless logged_in?
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to admin_employee_details_url(:id => @employee.id)
    else
      render 'employee'
    end
  end

  def edit
    redirect_to root_url unless logged_in?
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
  
      if @employee.update_attributes(employee_update)
      redirect_to admin_employee_url
    else
      
      render employee_portal_path
    end
  end

  def destroy
    Employee.find(params[:id]).destroy
    redirect_to admin_employee_url
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :password,
                                  :password_confirmation, :gender, :designation, :phone, :date_of_join, :date_of_birth, :address, :active, :username)
  end

  def employee_update
    params.require(:employee).permit(:name, :email, :gender, :designation, :phone, :date_of_join, :date_of_birth, :address, :active, :username, :personal_email)
  end

end
