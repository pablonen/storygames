require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_search_url
    assert_response :success
  end

  test "should get search" do
    get search_url, params: { query: "eero" }
    assert_response :success
  end
end
