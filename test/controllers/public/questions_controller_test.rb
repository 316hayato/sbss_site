require "test_helper"

class Public::QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_questions_new_url
    assert_response :success
  end

  test "should get confirm" do
    get public_questions_confirm_url
    assert_response :success
  end

  test "should get thanx" do
    get public_questions_thanx_url
    assert_response :success
  end
end
