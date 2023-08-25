require "test_helper"

class Public::ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_services_index_url
    assert_response :success
  end

  test "should get show" do
    get public_services_show_url
    assert_response :success
  end
end
