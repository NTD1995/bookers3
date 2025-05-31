require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get notifications_update_url
    assert_response :success
  end
end
