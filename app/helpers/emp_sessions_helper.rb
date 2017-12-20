module EmpSessionsHelper
    # Logs in the given employee.
  def emplog_in(employee)
    session[:employee_id] = employee.id
  end

    # Remembers a employee in a persistent session.
  def empremember(employee)
    employee.remember
    cookies.permanent.signed[:employee_id] = employee.id
    cookies.permanent[:remember_token] = employee.remember_token
  end

  # Returns the current logged-in employee (if any).
  def current_employee
        if (employee_id = session[:employee_id])
      @current_employee ||= Employee.find_by(id: employee_id)
    elsif (employee_id = cookies.signed[:employee_id])
      employee = Employee.find_by(id: employee_id)
      if employee && employee.authenticated?(cookies[:remember_token])
        log_in employee
        @current_employee = employee
      end
    end

  end

  # Returns true if the employee is logged in, false otherwise.
  def emplogged_in?
    !current_employee.nil?
  end

    # Logs out the current employee.
  def emplog_out
    empforget(current_employee)
    session.delete(:employee_id)
    @current_employee = nil
  end

    # Forgets a employee.
  def empforget(employee)
    employee.forget
    cookies.delete(:employee_id)
    cookies.delete(:remember_token)

  end

end
