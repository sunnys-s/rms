require "application_system_test_case"

class NomineesTest < ApplicationSystemTestCase
  setup do
    @nominee = nominees(:one)
  end

  test "visiting the index" do
    visit nominees_url
    assert_selector "h1", text: "Nominees"
  end

  test "creating a Nominee" do
    visit nominees_url
    click_on "New Nominee"

    fill_in "Emp code", with: @nominee.emp_code
    fill_in "Nomination", with: @nominee.nomination_id
    fill_in "User", with: @nominee.user_id
    click_on "Create Nominee"

    assert_text "Nominee was successfully created"
    click_on "Back"
  end

  test "updating a Nominee" do
    visit nominees_url
    click_on "Edit", match: :first

    fill_in "Emp code", with: @nominee.emp_code
    fill_in "Nomination", with: @nominee.nomination_id
    fill_in "User", with: @nominee.user_id
    click_on "Update Nominee"

    assert_text "Nominee was successfully updated"
    click_on "Back"
  end

  test "destroying a Nominee" do
    visit nominees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Nominee was successfully destroyed"
  end
end
