class EmployeePortalController < ApplicationController
  def home
    redirect_to root_url unless emplogged_in?
    @employee = current_employee
  end

  def login
  end

  def dashboard
    redirect_to root_url unless emplogged_in?
  end

  def update
    @employee = Employee.find(params[:id])
   

      if @employee.update_attributes(employee_params_with_pic)      
      redirect_to employee_portal_dashboard_url
    else
      
      render employee_portal_path
    end
  end

  private

  def employee_params_with_pic
    params.require(:employee).permit( :phone, :personal_email, :address, :picture)
  end
  
end
