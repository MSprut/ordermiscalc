require 'test_helper'

class CalculationCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @calculation_category = calculation_categories(:one)
  end

  test "should get index" do
    get calculation_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_calculation_category_url
    assert_response :success
  end

  test "should create calculation_category" do
    assert_difference('CalculationCategory.count') do
      post calculation_categories_url, params: { calculation_category: {  } }
    end

    assert_redirected_to calculation_category_url(CalculationCategory.last)
  end

  test "should show calculation_category" do
    get calculation_category_url(@calculation_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_calculation_category_url(@calculation_category)
    assert_response :success
  end

  test "should update calculation_category" do
    patch calculation_category_url(@calculation_category), params: { calculation_category: {  } }
    assert_redirected_to calculation_category_url(@calculation_category)
  end

  test "should destroy calculation_category" do
    assert_difference('CalculationCategory.count', -1) do
      delete calculation_category_url(@calculation_category)
    end

    assert_redirected_to calculation_categories_url
  end
end
