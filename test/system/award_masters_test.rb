require "application_system_test_case"

class AwardMastersTest < ApplicationSystemTestCase
  setup do
    @award_master = award_masters(:one)
  end

  test "visiting the index" do
    visit award_masters_url
    assert_selector "h1", text: "Award Masters"
  end

  test "creating a Award master" do
    visit award_masters_url
    click_on "New Award Master"

    fill_in "Award type", with: @award_master.award_type
    fill_in "Title", with: @award_master.title
    click_on "Create Award master"

    assert_text "Award master was successfully created"
    click_on "Back"
  end

  test "updating a Award master" do
    visit award_masters_url
    click_on "Edit", match: :first

    fill_in "Award type", with: @award_master.award_type
    fill_in "Title", with: @award_master.title
    click_on "Update Award master"

    assert_text "Award master was successfully updated"
    click_on "Back"
  end

  test "destroying a Award master" do
    visit award_masters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Award master was successfully destroyed"
  end
end
