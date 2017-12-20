require 'test_helper'

class EmpSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get emp_sessions_new_url
    assert_response :success
  end

end
