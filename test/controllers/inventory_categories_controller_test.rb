require 'test_helper'

class InventoryCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_category = inventory_categories(:one)
  end

  test "should get index" do
    get inventory_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_inventory_category_url
    assert_response :success
  end

  test "should create inventory_category" do
    assert_difference('InventoryCategory.count') do
      post inventory_categories_url, params: { inventory_category: {  } }
    end

    assert_redirected_to inventory_category_url(InventoryCategory.last)
  end

  test "should show inventory_category" do
    get inventory_category_url(@inventory_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventory_category_url(@inventory_category)
    assert_response :success
  end

  test "should update inventory_category" do
    patch inventory_category_url(@inventory_category), params: { inventory_category: {  } }
    assert_redirected_to inventory_category_url(@inventory_category)
  end

  test "should destroy inventory_category" do
    assert_difference('InventoryCategory.count', -1) do
      delete inventory_category_url(@inventory_category)
    end

    assert_redirected_to inventory_categories_url
  end
end
