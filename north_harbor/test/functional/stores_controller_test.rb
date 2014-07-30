require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post :create, :store => { }
    end

    assert_redirected_to store_path(assigns(:store))
  end

  test "should show store" do
    get :show, :id => stores(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stores(:one).to_param
    assert_response :success
  end

  test "should update store" do
    put :update, :id => stores(:one).to_param, :store => { }
    assert_redirected_to store_path(assigns(:store))
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete :destroy, :id => stores(:one).to_param
    end

    assert_redirected_to stores_path
  end
end
