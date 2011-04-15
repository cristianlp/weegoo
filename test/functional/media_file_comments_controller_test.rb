require 'test_helper'

class MediaFileCommentsControllerTest < ActionController::TestCase
  setup do
    @media_file_comment = media_file_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:media_file_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create media_file_comment" do
    assert_difference('MediaFileComment.count') do
      post :create, :media_file_comment => @media_file_comment.attributes
    end

    assert_redirected_to media_file_comment_path(assigns(:media_file_comment))
  end

  test "should show media_file_comment" do
    get :show, :id => @media_file_comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @media_file_comment.to_param
    assert_response :success
  end

  test "should update media_file_comment" do
    put :update, :id => @media_file_comment.to_param, :media_file_comment => @media_file_comment.attributes
    assert_redirected_to media_file_comment_path(assigns(:media_file_comment))
  end

  test "should destroy media_file_comment" do
    assert_difference('MediaFileComment.count', -1) do
      delete :destroy, :id => @media_file_comment.to_param
    end

    assert_redirected_to media_file_comments_path
  end
end
