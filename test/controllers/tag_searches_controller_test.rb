require "test_helper"

class TagSearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get tag_searches_search_url
    assert_response :success
  end
end
