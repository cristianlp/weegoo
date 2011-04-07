require 'test_helper'

class MediaFilesControllerTest < ActionController::TestCase
  setup do
    @media_file = media_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:media_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create media_file" do
    assert_difference('MediaFile.count') do
      post :create, :media_file => @media_file.attributes
    end

    assert_redirected_to media_file_path(assigns(:media_file))
  end

  test "should show media_file" do
    get :show, :id => @media_file.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @media_file.to_param
    assert_response :success
  end

  test "should update media_file" do
    put :update, :id => @media_file.to_param, :media_file => @media_file.attributes
    assert_redirected_to media_file_path(assigns(:media_file))
  end

  test "should destroy media_file" do
    assert_difference('MediaFile.count', -1) do
      delete :destroy, :id => @media_file.to_param
    end

    assert_redirected_to media_files_path
  end
end
