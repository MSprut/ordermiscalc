require "application_system_test_case"

class CustomerCategoriesTest < ApplicationSystemTestCase
  setup do
    @customer_category = customer_categories(:one)
  end

  test "visiting the index" do
    visit customer_categories_url
    assert_selector "h1", text: "Customer Categories"
  end

  test "creating a Customer category" do
    visit customer_categories_url
    click_on "New Customer Category"

    click_on "Create Customer category"

    assert_text "Customer category was successfully created"
    click_on "Back"
  end

  test "updating a Customer category" do
    visit customer_categories_url
    click_on "Edit", match: :first

    click_on "Update Customer category"

    assert_text "Customer category was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer category" do
    visit customer_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer category was successfully destroyed"
  end
end
