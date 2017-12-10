require 'test_helper'

class EmployeePortalControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get employee_portal_path
    assert_response :success
  end

  test "should get login" do
    get employee_portal_login_url
    assert_response :success
  end

  test "should get dashboard" do
    get employee_portal_dashboard_url
    assert_response :success
  end

end
