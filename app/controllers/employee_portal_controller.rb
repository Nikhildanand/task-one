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
   
    if ((params[:employee][:phone]).blank? ? true : @employee.update_attribute(:phone, params[:employee][:phone]) ) && ((params[:employee][:personal_email]).blank? ? true : @employee.update_attribute(:personal_email, params[:employee][:personal_email]) ) && ((params[:employee][:address]).blank? ? true : @employee.update_attribute(:address, params[:employee][:address]) )     
      # Handle a successful update.
      redirect_to employee_portal_dashboard_url
    else
      
      render employee_portal_path
    end
  end

  # private

  # def employee_params
  #   params.require(:employee).permit( :phone, :personal_email, :address)
  # end
  
end
