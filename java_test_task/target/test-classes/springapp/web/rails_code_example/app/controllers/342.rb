class UsersController < ApplicationController

  before_filter :authenticate_user!, :except => [:contact_us, :sitemap, :get_username, :validate_user_name, :register_user, :privacy, :thank_you, :not_allowed_to_use, :blank_page_new_user_registration, :save_avatar, :home, :terms_conditions]
  before_filter :get_categories, :only => [:home]
  before_filter :categories_list, :only => [:home]

  def unsubscribe_from_notifications
   User.update_all({:comment_notification_enable => false, :comment_notification_token => nil}, {:id => params[:user]}) if params[:type]=="1" and User.find(params[:user]).comment_notification_token==params[:n_token]
   User.update_all({:follow_notification_enable => false,   :follow_notification_token => nil}, {:id => params[:user]}) if params[:type]=="2" and User.find(params[:user]).follow_notification_token==params[:n_token]
   unsubscribe_text="You will no longer receive email notifications when someone replies to a entity you post" if params[:type]=="1"
   unsubscribe_text="You will no longer receive email notifications when someone you follow posts a entity" if params[:type]=="2"
   redirect_to root_path, :flash => { :unsubscribe => "true", :unsubscribe_text=> unsubscribe_text }
  end

  def register_user
    reply = FacebookAuthentication::parse_signed_request(params[:signed_request], ENV["FACEBOOK_APP_SECRET"] || "e3184262714695fc0af73abe85da9ae4")
    user = User.apply_facebook(reply["registration"], reply["user_id"])

    sign_in(user, :bypass => true)
    redirect_to root_path
  end

  def follow
    follow_relation = FollowRelation.new
    follow_relation.receiver_id = current_user.id
    follow_relation.sender_id = params[:id]
    follow_relation.save! unless current_user.does_receive_from?(params[:id])
    render :text=>follow_relation.errors.blank? ? ["unfollow"] : ["follow"] and return
  end

  def unfollow
    FollowRelation.delete_all(:receiver_id => current_user.id, :sender_id=>params[:id])
    render :text=>current_user.does_receive_from?(params[:id]).blank? ? ["follow"] : ["unfollow"] and return
  end

  def get_username
    render :layout => nil
  end

  def validate_user_name
    user = User.find_by_user_name params[:user_name]
    render :text => "OK", :status=> 200 and return if user.blank?
    render :text => "User name has already been taken", :status=> 400 and return
  end

  def home
    redirect_to new_user_session_path and return if current_user.blank?
    @my_entitys = entity.where(["user_id = ? and parent_entity_id is NULL AND archived_at is NULL ", current_user.id]).order("updated_at DESC") if !is_mobile_device_local?
    @my_entitys = entity.where(["user_id = ? and parent_entity_id is NULL AND archived_at is NULL ", current_user.id]).order("updated_at DESC").page(params[:page]).per(10) if is_mobile_device_local?
    @last_entity = entity.where(["user_id = ? and parent_entity_id is NULL AND archived_at is NULL ", current_user.id]).includes(:user, :entitys_ratings).order("created_at desc").last
    @entitys = entity.where("parent_entity_id is NULL AND archived_at is NULL").includes(:user, :entitys_ratings).order("created_at desc").page(params[:page]).per(20)
    @tags = entity.tag_counts.order("count DESC").limit(10)
    @my_replies_count = {}
    @my_entitys.each { |entity| @my_replies_count[entity.id]= User.find(current_user.id).notifications.calculate(:count, :all, :conditions => {read: false, entity_id: entity.replies}) }
    #@forward = "my_entitys"
  end

  def settings
    render :layout => "blank"
  end

  def sitemap
    render :layout => "blank" 
  end

  def save_settings
    @user = User.find current_user.id
    @user.update_attributes(params[:user])
    
    sign_in(@user, :bypass => true)
    if @user.errors.blank?
      render text: "saved", status: :ok and return
    else
      render json: @user.errors, status: :ok and return
    end
  end
  
  def get_avatar
    @user = User.find current_user.id
    render text: @user.avatar.thumb.url, status: :ok
  end
  
  def save_avatar
    @user = User.find current_user.id
    @user.avatar = params[:avatar]
    if @user.save
      render :partial => "shared/userpic", :locals => { :current_user => @user }, status: :ok  and return
#      render action: "settings", layout: "blank", :locals => { :current_user => @user }, status: :ok and return
    else
      render text: @user.errors, status: :ok and return
    end    
  end

  def contact_us
    if request.post?
      cs = ContactUs.new params[:contact_us]

      if cs.save 
        SystemMailer.contact_us(cs).deliver
        render :text=>"saved" and return
      else
      render json: cs.errors, status: :ok and return
      end
    else
      @contact_us = ContactUs.new
      @contact_us.textcaptcha
      render :layout => "blank" and return
    end  
  end
  
  def thank_you
    respond_to do |format|
      format.html {
        render :layout => "blank" and return
      }
      format.mobile {
        render :layout => "application" and return
      }
    end
  end

  def not_allowed_to_use
    respond_to do |format|
      format.html {
        render :layout => "blank" and return
      }
      format.mobile {
        render :layout => "application" and return
      }
    end
  end
  
  def blank_page_new_user_registration
    render :layout => "blank" and return
  end
  
  def notifications
    @notifications = Notification.where(:user_id=>current_user.id, :read=>false)
    Notification.update_all({:read=>true}, ["id in (?)", @notifications.collect(&:id)])
    render :layout=>"blank"
  end

  def deactivate
    current_user.update_attribute(:locked_at, Time.now)
    sign_out(current_user)
    render :layout => false, :text => "Locked" and return
  end

  def toggle_anonymous
    if current_user.present?
      user = User.find current_user.id
      user.update_attribute(:anonymous, !user.anonymous)
      render :text => user.anonymous
      return
    end
  end

  def privacy
    render :partial => "shared/privacy" and return
  end
  
  def terms_conditions
    respond_to do |format|
      format.html {
        redirect_to controller: "entitys", action: "err404" and return
      }
      format.mobile {
        render :layout => "application" and return
      }
    end
  end

  private

  def base64_url_decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end
end
