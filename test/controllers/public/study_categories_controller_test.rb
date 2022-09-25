require "test_helper"

class Public::StudyCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_study_categories_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_study_categories_edit_url
    assert_response :success
  end

  test "should get new" do
    get public_study_categories_new_url
    assert_response :success
  end
end
