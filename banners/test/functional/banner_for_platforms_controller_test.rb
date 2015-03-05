require 'test_helper'

class BannerForPlatformsControllerTest < ActionController::TestCase
  setup do
    @banner_for_platform = banner_for_platforms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banner_for_platforms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banner_for_platform" do
    assert_difference('BannerForPlatform.count') do
      post :create, banner_for_platform: { amount_clicks: @banner_for_platform.amount_clicks, amount_views: @banner_for_platform.amount_views, default: @banner_for_platform.default, max_views: @banner_for_platform.max_views }
    end

    assert_redirected_to banner_for_platform_path(assigns(:banner_for_platform))
  end

  test "should show banner_for_platform" do
    get :show, id: @banner_for_platform
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @banner_for_platform
    assert_response :success
  end

  test "should update banner_for_platform" do
    put :update, id: @banner_for_platform, banner_for_platform: { amount_clicks: @banner_for_platform.amount_clicks, amount_views: @banner_for_platform.amount_views, default: @banner_for_platform.default, max_views: @banner_for_platform.max_views }
    assert_redirected_to banner_for_platform_path(assigns(:banner_for_platform))
  end

  test "should destroy banner_for_platform" do
    assert_difference('BannerForPlatform.count', -1) do
      delete :destroy, id: @banner_for_platform
    end

    assert_redirected_to banner_for_platforms_path
  end
end
