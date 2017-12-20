require 'test_helper'

class AdminsLoginTest < ActionDispatch::IntegrationTest

  def setup
    @admin = admins(:nikhil)
  end

  test "login with invalid information" do
    get admin_login_path
    assert_template 'sessions/new'
    post admin_login_path, params: { session: { name: "", password: "" } }
    assert_template 'sessions/new'
    get root_path
  end

  test "login with valid information followed by logout" do
    get admin_login_path
    post admin_login_path, params: { session: { name: @admin.name,
                                          password: 'Ha66y@Air' } }
    assert is_logged_in?
    assert_redirected_to admin_dashboard_url
    follow_redirect!
    assert_select "a[href=?]", admin_login_path, count: 0
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", logout_path,      count: 0

  end

    test "authenticated? should return false for a user with nil digest" do
    assert_not @admin.authenticated?('')
  end

end
