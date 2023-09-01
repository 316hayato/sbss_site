require "test_helper"

class Public::RequestListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_request_lists_index_url
    assert_response :success
  end
end
