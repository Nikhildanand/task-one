class EmpSessionsController < ApplicationController
  def new
  end

  def create
    employee = Employee.find_by(username: params[:session][:username].downcase)
    if employee && employee.authenticate(params[:session][:password])
      # Log the employee in and redirect to the employee's show page.
      emplog_in employee
      empremember employee
      redirect_to employee_portal_dashboard_url

    else
      # flash[:danger] = 'Invalid username/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    emplog_out
    redirect_to root_url

  end
end
