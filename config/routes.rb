Rails.application.routes.draw do

  get 'emp_sessions/new'

  get 'admin/edit'
  patch '/admin/edit', to: 'admin#update'
  delete '/admin/delete', to: 'admin#destroy'


  
  get '/employee_portal', to: 'employee_portal#home'
  patch '/employee_portal', to: 'employee_portal#update'

  root 'emp_sessions#new'
  post '/employee_portal/login', to: 'emp_sessions#create'
  delete '/emplogout', to: 'emp_sessions#destroy'

  get 'employee_portal/dashboard'

  get '/admin/login', to: 'sessions#new'
  post '/admin/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'admin/dashboard'

  get 'admin/employee'

  get 'admin/add_employee'
  post 'admin/add_employee', to: 'admin#create'

  get 'admin/employee_details'
  post 'admin/employee_details'

  get 'admin/projects'
  
  resource :employees
end