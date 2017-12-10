Rails.application.routes.draw do
  get '/employee_portal', to: 'employee_portal#home'

  get 'employee_portal/login'

  get 'employee_portal/dashboard'

  get 'admin/login'

  get 'admin/dashboard'

  get 'admin/employee'

  get 'admin/add_employee'

  get 'admin/employee_details'

  root 'home#home'

end
