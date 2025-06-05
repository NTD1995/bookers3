require "test_helper"

class ReadingStatusesControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get reading_statuses_destroy_url
    assert_response :success
  end

  test "should get update" do
    get reading_statuses_update_url
    assert_response :success
  end

  test "should get create" do
    get reading_statuses_create_url
    assert_response :success
  end
end
