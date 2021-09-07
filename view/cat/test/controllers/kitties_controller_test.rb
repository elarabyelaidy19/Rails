require "test_helper"

class KittiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kitties_index_url
    assert_response :success
  end

  test "should get show" do
    get kitties_show_url
    assert_response :success
  end
end
