module SessionsHelper

  # Logs in the given user.
  def log_in(admin)
    session[:admin_id] = admin.id
  end

  # Remembers a user in a persistent session.
  def remember(admin)
    admin.remember
    cookies.permanent.signed[:admin_id] = admin.id
    cookies.permanent[:remember_token] = admin.remember_token
  end

    # Returns the current logged-in user (if any).
  def current_user
    if (admin_id = session[:admin_id])
      @current_user ||= Admin.find_by(id: admin_id)
    elsif (admin_id = cookies.signed[:admin_id])
      admin = Admin.find_by(id: admin_id)
      if admin && admin.authenticated?(cookies[:remember_token])
        log_in admin
        @current_user = admin
      end   
    end
 
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:admin_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:admin_id)
    @current_user = nil
  end
end 