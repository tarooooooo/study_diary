require "test_helper"

class Public::LearningDiariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_learning_diaries_index_url
    assert_response :success
  end

  test "should get new" do
    get public_learning_diaries_new_url
    assert_response :success
  end
end
