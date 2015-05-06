require 'test_helper'

class BreakingentitysControllerTest < ActionController::TestCase

  setup do
    @user = users(:one)
    sign_in  @user
  end

  test "should rate up" do
    assert_difference('BreakingentitysRating.count') do
    post :rate_up, :id=>1
    assert_response :success
    assert_template
    end
  end

   test "should load comments" do
    bf = Breakingentity.find 1
    post :load_comments, :id=>1, :page=>1
    assert_response :success
    assert_template "entitys/_bf_comments_expanded"
    assigns(:breakingentity) == bf
    assigns(:page)==2
    assigns(:layout)==false
  end

  test "should collapse comments" do
    bf = Breakingentity.find 1
    post :collapse_comments, :id=>1
    assert_response :success
    assert_template "entitys/_bf_comments_collapsed"
    assigns(:breakingentity) == bf
    assigns(:layout)==false
  end

  test "should create bf comment" do
    bf = Breakingentity.find 1
    assert_difference('BfComment.count') do
    post :create_bf_comment, :bf_comment=>{:breakingentity_id=>1, :body=>"testbody"}
    assert_response :success
    assert_template "entitys/_bf_comments_collapsed"
    assigns(:breakingentity) == bf
    assigns(:layout)==false
    end
  end

end
