require "application_system_test_case"

class CalculationCategoriesTest < ApplicationSystemTestCase
  setup do
    @calculation_category = calculation_categories(:one)
  end

  test "visiting the index" do
    visit calculation_categories_url
    assert_selector "h1", text: "Calculation Categories"
  end

  test "creating a Calculation category" do
    visit calculation_categories_url
    click_on "New Calculation Category"

    click_on "Create Calculation category"

    assert_text "Calculation category was successfully created"
    click_on "Back"
  end

  test "updating a Calculation category" do
    visit calculation_categories_url
    click_on "Edit", match: :first

    click_on "Update Calculation category"

    assert_text "Calculation category was successfully updated"
    click_on "Back"
  end

  test "destroying a Calculation category" do
    visit calculation_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Calculation category was successfully destroyed"
  end
end
