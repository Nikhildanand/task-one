require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest


  test "root link" do
    get root_path
    assert_template 'home/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", admin_login_url
    assert_select "a[href=?]", employee_portal_login_url
  end

  test "admin pages link" do
    get admin_dashboard_url
    assert_template 'admin/dashboard'
    assert_select "a[href=?]", admin_dashboard_url     
    assert_select "a[href=?]", admin_employee_url     
  end

  test "employee pages link" do
    get employee_portal_dashboard_url
    assert_template 'employee_portal/dashboard'
    assert_select "a[href=?]", employee_portal_dashboard_url
    assert_select "a[href=?]", employee_portal_path
  end
end
