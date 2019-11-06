require "application_system_test_case"

class NominationsTest < ApplicationSystemTestCase
  setup do
    @nomination = nominations(:one)
  end

  test "visiting the index" do
    visit nominations_url
    assert_selector "h1", text: "Nominations"
  end

  test "creating a Nomination" do
    visit nominations_url
    click_on "New Nomination"

    fill_in "Award", with: @nomination.award_id
    fill_in "Nomination type", with: @nomination.nomination_type
    click_on "Create Nomination"

    assert_text "Nomination was successfully created"
    click_on "Back"
  end

  test "updating a Nomination" do
    visit nominations_url
    click_on "Edit", match: :first

    fill_in "Award", with: @nomination.award_id
    fill_in "Nomination type", with: @nomination.nomination_type
    click_on "Update Nomination"

    assert_text "Nomination was successfully updated"
    click_on "Back"
  end

  test "destroying a Nomination" do
    visit nominations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Nomination was successfully destroyed"
  end
end
