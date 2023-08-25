require "test_helper"

class Admin::RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_requests_show_url
    assert_response :success
  end
end
