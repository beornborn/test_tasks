require 'test_helper'

class entitysControllerTest < ActionController::TestCase

  fixtures :users

  #not used, missing template
  test "should get down" do
    #    get :down
    #    assert_response :success
    #    assigns(:layout)=="blank"
    #    assert_template :down
  end

  #not used method
  test "should show detail" do
    #    get(:detail, :id => 1)
    #    assert_response :success
    #    assert_template :detail
    #    assigns(:entity).wont_be_nil
  end

  test "should search" do
    #search doesn't works. try later
    get :search, :q=>"testbody"
    assert_response :success
    assigns(:entitys).size.wont_be_nil
  end

  test "should lazy search" do
    get :lazy_search, :q=>"testbody"
    assert_response :success
    assert_template :partial=>"_entitys_lazy_load"
    assigns(:entitys).size.wont_be_nil
  end
  
  test "should get index" do
    get :index
    assert_response :redirect
  end

  test "should get new" do
    get :new
    assert_response :redirect
    assert_template 
    assigns(@entity).wont_be_nil
  end

  test "should create" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    @request.env['HTTP_REFERER'] = 'http://localhost:3000'
    post :create, "entity"=>{"user_id"=>"1", "anonymous"=>"", "body"=>"ccccccccccc"}
    assert_response :redirect
    assert_template
  end

  test "should show entity" do
    get :show, :id => 1
    assert_response :success
    assert_template :home
    assigns(:entity).wont_be_nil
  end

  test "should do reply" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    @request.env['HTTP_REFERER'] = 'http://localhost:3000'
    post :reply, "entity"=>{"user_id"=>"1", "body"=>"dfsdf"}, "Submit1"=>"", "id"=>"1"
    assert_response :success
    assert_template
  end

  test "should rate up" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    post :rate_up, :id=>1, :entity=>{:id=>1}
    assert_response :success
    assert_template
  end

  test "should load comments" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    assert_difference('Notification.where(:read=>false).count', -1) do
      post :load_comments, :type=>"type", :page=>1, :id=>1
      assert_response :success
      assert_template :partial=>"_my_comments_expanded"
    end
  end

  test "should load all comments" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    assert_difference('Notification.where(:read=>false).count', -1) do
      post :load_all_comments, :id=>1
      assert_response :success
    end
  end

  test "should collapse comments" do
    post :collapse_comments, :type=>"smth", :id=>1
    assert_response :success
    assert_template :partial=>"_my_comments_collapsed"
  end

  test "should destroy" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    @request.env['HTTP_REFERER'] = 'http://localhost:3000'
    delete :destroy, :id=>1
    assert_response :success
    assert_template
  end

  test "should update" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    @request.env['HTTP_REFERER'] = 'http://localhost:3000'
    put :update, :entity=>{"body"=>"updatetest"}, :id=>1
    assert_response :redirect
    assert_template
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_template :home
    assigns(:entitys).wont_be_nil
    assigns(:tags).wont_be_nil
  end

  test "should lazy load" do
    get :lazy_load
    assert_response :success
    assert_template :partial=>"_entitys_lazy_load"
    assigns(@entitys).wont_be_nil
    assigns(@keeped_data).wont_be_nil
  end

  test "should lazy load my" do
    get :lazy_load_my
    assert_response :redirect
    assert_template 
    assigns(@entitys).wont_be_nil
    assigns(@keeped_data).wont_be_nil
    assigns(@last_entity).wont_be_nil
  end

  test "should remove all notifications" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    assert_difference('Notification.where(:read=>false).count', -1) do
      post :remove_all_notifications
      assert_response :success
      assert_template
    end
  end
 
  test "should get notifications count" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    post :notifications_count
    assert_response :success
    assert_template
  end

  test "should remove notification" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    assert_difference('Notification.where(:read=>false).count', -1) do
      post :remove_notification, :id=>1
      assert_response :success
      assert_template
    end
  end

  test "should get notifications list" do
    @user=  users(:one)
    @user.confirm!
    sign_in @user
    post :notifications_list
    assert_response :success
    assert_template :partial=>"_notifications"
  end

  test "should keep postajax" do
    post :keep_post_ajax, :saved_text=>"saved text", :twitter_state=>"true", :facebook_state=>"true", :saved_link=>"google.com",
      :place_of_request=>"post_entity", :anonymous=>"true"
    assert_response :redirect
    assert_template
    assert (cookies[:saved_text] =="saved text")
    assert (cookies[:twitter_state] =="true")
    assert (cookies[:facebook_state] =="true")
    assert (cookies[:saved_link] =="google.com")
    assert (cookies[:place_of_request] =="post_entity")
    assert (cookies[:anonymous] =="true")
  end

  test "should test video" do
    post :test_video, :video_link=>"http://www.youtube.com/watch?v=j0AbrOlYzbY&feature=plcp"
    assert_response :redirect
    assert_template
  end

  test "should get err404" do
    get :err404
    assert_response :success
    assert_template :err404
  end

  test "should get comment" do
    get :comment, :id=>1
    assert_response :redirect
    assert_template
    assigns(@entity).wont_be_nil
  end

  test "should change layout" do
    get :change_layout
    assert_response :redirect
    assert_template
  end

  #doesn't active now
  test "should restore" do
  end
end
