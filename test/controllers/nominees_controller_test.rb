require 'test_helper'

class NomineesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nominee = nominees(:one)
  end

  test "should get index" do
    get nominees_url
    assert_response :success
  end

  test "should get new" do
    get new_nominee_url
    assert_response :success
  end

  test "should create nominee" do
    assert_difference('Nominee.count') do
      post nominees_url, params: { nominee: { emp_code: @nominee.emp_code, nomination_id: @nominee.nomination_id, user_id: @nominee.user_id } }
    end

    assert_redirected_to nominee_url(Nominee.last)
  end

  test "should show nominee" do
    get nominee_url(@nominee)
    assert_response :success
  end

  test "should get edit" do
    get edit_nominee_url(@nominee)
    assert_response :success
  end

  test "should update nominee" do
    patch nominee_url(@nominee), params: { nominee: { emp_code: @nominee.emp_code, nomination_id: @nominee.nomination_id, user_id: @nominee.user_id } }
    assert_redirected_to nominee_url(@nominee)
  end

  test "should destroy nominee" do
    assert_difference('Nominee.count', -1) do
      delete nominee_url(@nominee)
    end

    assert_redirected_to nominees_url
  end
end
