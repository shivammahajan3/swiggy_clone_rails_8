require "test_helper"

class RestrosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get restros_index_url
    assert_response :success
  end
end
