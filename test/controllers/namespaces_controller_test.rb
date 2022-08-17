require "test_helper"

class NamespacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get namespace_index_url
    assert_response :success
  end

  test "should get show" do
    get namespace_show_url
    assert_response :success
  end

  test "should get create" do
    get namespace_create_url
    assert_response :success
  end
end
