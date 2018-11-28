require "application_system_test_case"

class AccountantPreferencesTest < ApplicationSystemTestCase
  setup do
    @accountant_preference = accountant_preferences(:one)
  end

  test "visiting the index" do
    visit accountant_preferences_url
    assert_selector "h1", text: "Accountant Preferences"
  end

  test "creating a Accountant preference" do
    visit accountant_preferences_url
    click_on "New Accountant Preference"

    click_on "Create Accountant preference"

    assert_text "Accountant preference was successfully created"
    click_on "Back"
  end

  test "updating a Accountant preference" do
    visit accountant_preferences_url
    click_on "Edit", match: :first

    click_on "Update Accountant preference"

    assert_text "Accountant preference was successfully updated"
    click_on "Back"
  end

  test "destroying a Accountant preference" do
    visit accountant_preferences_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Accountant preference was successfully destroyed"
  end
end
