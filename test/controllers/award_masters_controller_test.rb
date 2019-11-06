require 'test_helper'

class AwardMastersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @award_master = award_masters(:one)
  end

  test "should get index" do
    get award_masters_url
    assert_response :success
  end

  test "should get new" do
    get new_award_master_url
    assert_response :success
  end

  test "should create award_master" do
    assert_difference('AwardMaster.count') do
      post award_masters_url, params: { award_master: { award_type: @award_master.award_type, title: @award_master.title } }
    end

    assert_redirected_to award_master_url(AwardMaster.last)
  end

  test "should show award_master" do
    get award_master_url(@award_master)
    assert_response :success
  end

  test "should get edit" do
    get edit_award_master_url(@award_master)
    assert_response :success
  end

  test "should update award_master" do
    patch award_master_url(@award_master), params: { award_master: { award_type: @award_master.award_type, title: @award_master.title } }
    assert_redirected_to award_master_url(@award_master)
  end

  test "should destroy award_master" do
    assert_difference('AwardMaster.count', -1) do
      delete award_master_url(@award_master)
    end

    assert_redirected_to award_masters_url
  end
end
