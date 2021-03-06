class SessionsController < ApplicationController

  def new
  end

  def create
    
    admin = Admin.find_by(name: params[:session][:name])
    
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      params[:session][:remember_me] == '1' ? remember(admin) : forget(admin)
      redirect_to admin_dashboard_url
    else      
      # flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
