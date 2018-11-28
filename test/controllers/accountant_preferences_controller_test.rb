require 'test_helper'

class AccountantPreferencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accountant_preference = accountant_preferences(:one)
  end

  test "should get index" do
    get accountant_preferences_url
    assert_response :success
  end

  test "should get new" do
    get new_accountant_preference_url
    assert_response :success
  end

  test "should create accountant_preference" do
    assert_difference('AccountantPreference.count') do
      post accountant_preferences_url, params: { accountant_preference: {  } }
    end

    assert_redirected_to accountant_preference_url(AccountantPreference.last)
  end

  test "should show accountant_preference" do
    get accountant_preference_url(@accountant_preference)
    assert_response :success
  end

  test "should get edit" do
    get edit_accountant_preference_url(@accountant_preference)
    assert_response :success
  end

  test "should update accountant_preference" do
    patch accountant_preference_url(@accountant_preference), params: { accountant_preference: {  } }
    assert_redirected_to accountant_preference_url(@accountant_preference)
  end

  test "should destroy accountant_preference" do
    assert_difference('AccountantPreference.count', -1) do
      delete accountant_preference_url(@accountant_preference)
    end

    assert_redirected_to accountant_preferences_url
  end
end
