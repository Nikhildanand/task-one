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
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
   
    if  ((params[:employee][:name]).blank? ? true : @employee.update_attribute(:name, params[:employee][:name])) && 
        ((params[:employee][:gender]).blank? ? true : @employee.update_attribute(:gender, params[:employee][:gender])) && 
        ((params[:employee][:designation]).blank? ? true : @employee.update_attribute(:designation, params[:employee][:designation])) && 
        ((params[:employee][:phone]).blank? ? true : @employee.update_attribute(:phone, params[:employee][:phone])) && 
        ((params[:employee][:email]).blank? ? true : @employee.update_attribute(:email, params[:employee][:email])) && 
        ((params[:employee][:date_of_join]).blank? ? true : @employee.update_attribute(:date_of_join, params[:employee][:date_of_join])) && 
        ((params[:employee][:date_of_birth]).blank? ? true : @employee.update_attribute(:date_of_birth, params[:employee][:date_of_birth])) && 
        ((params[:employee][:active]).blank? ? true : @employee.update_attribute(:active, params[:employee][:active])) && 
        ((params[:employee][:username]).blank? ? true : @employee.update_attribute(:username, params[:employee][:username])) && 
        ((params[:employee][:personal_email]).blank? ? true : @employee.update_attribute(:personal_email, params[:employee][:personal_email])) && 
        ((params[:employee][:address]).blank? ? true : @employee.update_attribute(:address, params[:employee][:address]))     
      # Handle a successful update.
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

end
