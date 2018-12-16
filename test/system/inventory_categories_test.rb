require "application_system_test_case"

class InventoryCategoriesTest < ApplicationSystemTestCase
  setup do
    @inventory_category = inventory_categories(:one)
  end

  test "visiting the index" do
    visit inventory_categories_url
    assert_selector "h1", text: "Inventory Categories"
  end

  test "creating a Inventory category" do
    visit inventory_categories_url
    click_on "New Inventory Category"

    click_on "Create Inventory category"

    assert_text "Inventory category was successfully created"
    click_on "Back"
  end

  test "updating a Inventory category" do
    visit inventory_categories_url
    click_on "Edit", match: :first

    click_on "Update Inventory category"

    assert_text "Inventory category was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventory category" do
    visit inventory_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventory category was successfully destroyed"
  end
end
