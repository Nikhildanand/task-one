require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get admin_login_path
    assert_template 'sessions/new'
    post admin_login_path, params: { session: { name: "", password: "" } }
    assert_template 'sessions/new'
    get root_path
  end
end
