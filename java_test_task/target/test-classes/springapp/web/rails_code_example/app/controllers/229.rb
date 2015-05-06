class entitysController < ApplicationController
  #  ssl_required :signin,:signup,:forgot_password, :recent_pr , :recent_video_pr, :top_pr, :promotional_item   if  RAILS_ENV == "production"

  before_filter :user_logged_in, :only => [:reply, :rate_up, :destroy, :update, :toggle_anonymous, :create, :test_video, :new, :comment, :lazy_load_my, :remove_all_notifications, :notifications_count, :notifications_list]
  before_filter :get_entity, :only => [:detail, :show, :rate_up, :rate_down, :destroy, :update, :restore]
  before_filter :get_categories, :only => [:search, :show, :home]
  before_filter :get_breakingentitys, :only => [:search, :show, :home]
  before_filter :verfiy_action, :only => [:destroy, :update, :restore]
  before_filter :categories_list, :only => [:search, :new, :show, :home]

  def adv_signal_for_statmix
    StatsMix.track("Advertising",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] == 'www.entitys.com'
    StatsMix.track("Advertising staging",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] != 'www.entitys.com'
    render :text=>""
  end

  def share_signal_for_statmix
    StatsMix.track("Sharethis",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] == 'www.entitys.com'
    StatsMix.track("Sharethis staging",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] != 'www.entitys.com'
    render :text=>""
  end

  def down
    render :layout => "blank"
  end

  def detail
    Notification.update_all({:read => true}, {:user_id => current_user.id, :entity_id=> @entity.replies}) if current_user.present? and params[:read_notfication].to_i == 1
    render :layout=>false
  end

  def search
    StatsMix.track("Search",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] == 'www.entitys.com'
    StatsMix.track("Search staging",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] != 'www.entitys.com' and Rails.env!="test"
    if !params[:tag].blank?
      @entitys = entity.tagged_with(params[:tag]).where("parent_entity_id is NULL AND archived_at is NULL").order('created_at DESC').page(params[:page]).per(10)
      @tag = params[:tag]
      if Category.find_by_tag(params[:tag]).present?
        StatsMix.track("Category searches", 1, {:meta => {"category" => params[:tag],"layout"=>get_current_layout}}) if ENV["entityS_HOST"] == 'www.entitys.com'
        StatsMix.track("Category searches staging", 1, {:meta => {"category" => params[:tag],"layout"=>get_current_layout}}) if ENV["entityS_HOST"] != 'www.entitys.com'
      end
    else
      if params[:id].present?
        @entitys = entity.where(["id = ?", params[:id]]).order('created_at DESC')
      else
        search = Sunspot.search(entity) do
          keywords params[:q], :minimum_match => 0
          order_by :created_at, :desc
          with :parent_entity_id, nil
          with :archived_at, nil
          paginate :page => params[:page], :per_page => 10
        end
        anonym =  params[:q].upcase=="ANONYMOUS" ? true : false
        uuser= User.where("UPPER(user_name) = ?", params[:q].upcase).first
        if uuser.present?
          search2 = Sunspot.search(entity) do
            keywords "", :minimum_match => 0
            with :user_id, uuser.id unless anonym
            with :parent_entity_id, nil
            with :archived_at, nil
            with :anonymous, anonym
            order_by :created_at, :desc
            paginate :page => params[:page], :per_page => 10
          end
        end
        @entitys=search.results | (search2.present? ? search2.results : [])
        @q = params[:q]
      end
    end
    @tags = entity.tag_counts.order("count DESC").limit(10)
    @mode = "search"
    @keeped_data=get_data_from_session
    #@forward = "home"
    render :home
  end

  def lazy_search
    @entitys = if !params[:tag].blank?
      entity.tagged_with(params[:tag]).where("parent_entity_id is NULL AND archived_at is NULL").order('created_at DESC').page(params[:page]).per(10)
    else
      search = Sunspot.search(entity) do
        keywords params[:q], :minimum_match => 0
        order_by :created_at, :desc
        paginate :page => params[:page], :per_page => 10
      end
      search.results
    end
    @keeped_data=get_data_from_session
    #render :layout => false
    if params[:m].present?
      render :partial=> "entitys_lazy_load_mobile", :locals => {:entitys => @entitys}, :layout=>false and return
    else
      render :partial=> "entitys_lazy_load", :locals => {:entitys => @entitys}, :layout=>false and return
    end
  end

  def index
    #    @entitys = entity.where("parent_entity_id is NULL AND archived_at is NULL").joins(:user).includes(:entitys_ratings).order("created_at desc").page(params[:page]).per(5)
    #    @keeped_data=get_data_from_session
    redirect_to controller: "entitys", action: "err404" and return
  end

  def new
    @entity = entity.new
    respond_to do |format|
      format.html {
        render :layout => "application" and return
      }
      format.mobile {
        render :layout => "application" and return
      }
    end
  end

  def create
    #    result = Rakismet.akismet_call('comment-check', {:content => helpers.sanitize(params[:entity][:body], :tags => %w()), :author => "betBetbet", :user_ip=>"127.0.0.1"})
    #    logger.info "dddddddddddddddddd"
    #    logger.info env
    #    logger.info result.inspect
    #   entity = entity.create params[:entity]
    #   entity = entity.create ({:body => params[:entity][:body], :user_id => current_user.id, :anonymous => params[:entity][:anonymous]})
    entity = entity.create
    begin
      entity.body = Rails.env=='production' ? helpers.sanitize(params[:entity][:body].gsub(/(http:\/\/)\S*/i){|s|
          BITLY.shorten(s).short_url}.gsub(/www\.\S*/i){|s| BITLY.shorten("http://"+s).short_url}, :tags => %w()) : helpers.sanitize(params[:entity][:body], :tags => %w())
    rescue
      entity.body = helpers.sanitize(params[:entity][:body], :tags => %w())
    end
    entity.user_id = current_user.id
    entity.parent_entity_id = params[:entity][:parent_entity_id]
    #entity.anonymous = params[:entity][:anonymous]
    entity.anonymous = current_user.anonymous
    entity.photo = params[:entity][:photo]
    youtube_hash = youtube_embed(params[:entity][:video])
    if youtube_hash.present?
      begin
        youtube_video = YoutubeSearch.search(youtube_hash).first
      rescue
        redirect_to root_path and return
      end   
      entity.video = youtube_embed(params[:entity][:video]) if youtube_video['embeddable'] == true and !youtube_video.has_key?('racy')
    end

    entity.body += ' #'+ params[:category] if params[:category].present?

    #   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    if !entity.spam?
      entity.save
    
      if entity.photo.present?
        StatsMix.track("Photo",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] == 'www.entitys.com'
        StatsMix.track("Photo staging",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] != 'www.entitys.com'
        StatsMix.track("Photo from mobile",1) if ENV["entityS_HOST"] == 'www.entitys.com' and get_current_layout=="mobile"
        #StatsMix.track("Photo from mobile staging",1) if ENV["entityS_HOST"] != 'www.entitys.com' and get_current_layout=="mobile"
      end

      if entity.parent_entity_id.blank?
        StatsMix.track("Post",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] == 'www.entitys.com'
        StatsMix.track("Post staging",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] != 'www.entitys.com' and Rails.env!="test"
      else
        StatsMix.track("Comment",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] == 'www.entitys.com'
        StatsMix.track("Comment staging",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] != 'www.entitys.com' and Rails.env!="test"
      end
   
      category = Category.find_by_tag(params[:category])
      if category.present?
        category.counter += 1
        category.save
      end
      begin
        if Rails.env=='production'
          @link_for_social = entity.parent_entity_id.blank? ? BITLY.shorten(request.url+"/"+entity.id.to_s).short_url.gsub!('/','%2F') : BITLY.shorten(request.url+"/"+entity.parent_entity_id.to_s).short_url.gsub!('/','%2F')
        else
          @link_for_social = entity.parent_entity_id.blank? ? request.url+"/"+entity.id.to_s : request.url+"/"+entity.parent_entity_id.to_s
        end
      rescue
        @link_for_social = entity.parent_entity_id.blank? ? request.url+"/"+entity.id.to_s : request.url+"/"+entity.parent_entity_id.to_s
      end

      share = Hash.new
      share["twitter"] = @link_for_social if params[:postentity_twitter]
      share["facebook"] = @link_for_social if params[:postentity_facebook]
      share["body_entity"] = entity.body if (params[:postentity_facebook] or params[:postentity_twitter])

      flash[:share_params] = share if share.present?

      if(entity.parent_entity.blank?)
        entity.user.send_emails_to_followers(entity)
        #if(params[:forward] == "my_entitys")
        #redirect_to users_home_path and return
        #else
        redirect_to root_path and return
        #end
      else
        if entity.parent_entity.user_id!=entity.user_id then
          entity.parent_entity.user.update_attribute(:comment_notification_token, (Digest::MD5.hexdigest "#{SecureRandom.hex(10)}-#{DateTime.now.to_s}")) unless entity.parent_entity.user.comment_notification_token!=nil
          SystemMailer.reply_notification(entity.parent_entity.user, entity.parent_entity, entity.parent_entity.user.comment_notification_token, 1).deliver  if entity.parent_entity.user.comment_notification_enable.present?
          Notification.create(:user_id=>entity.parent_entity.user_id, :entity_id=>entity.id, :read=>false)
        end
        parententity = entity.find(entity.parent_entity_id)
        if is_mobile_device_local?
          redirect_to root_path and return
        else
          if(params[:comment_state] == "true")
            render :partial=> "comments_lazy_load", :locals => {:entity => parententity, :replies=> parententity.replies, :page=>99999, :link_for_social=>@link_for_social}, :layout=>false and return
          else
            render :partial=> "comments_collapsed", :locals => {:entity => parententity, :replies=> parententity.replies, :link_for_social=>@link_for_social}, :layout=>false and return
          end
        end
      end


      #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


    else
      if is_mobile_device_local?
        if entity.parent_entity.present?
          redirect_to comment_entity_path(params[:entity][:parent_entity_id]), :flash => { :error => "this man is a spamer" }
        else
          redirect_to new_entity_path, :flash => { :error => "this man is a spamer" }
        end
      else
        if entity.parent_entity.present?
          render :text=>"Your entity contains spam content. Please rewrite it in another way.", :layout=>false and return
        else
          redirect_to root_path, :flash => { :error => "this man is a spamer" }
        end
      end
    end
  end

  def show
    Notification.update_all({:read => true}, {:user_id => current_user.id, :entity_id=> @entity.replies}) if current_user
    if @entity.parent_entity_id.blank?
      @entitys = []
      @entitys.push(@entity)
      @tags = entity.tag_counts.order("count DESC").limit(10)
      @keeped_data=get_data_from_session
      render :home
    else
      redirect_to controller: "entitys", action: "err404" and return
    end
  end

  def reply
    params[:entity][:parent_entity_id] = params[:id]
    #    entity = entity.create params[:entity]
    entity = entity.create
    entity.body = params[:entity][:body]
    entity.user_id = current_user.id
    entity.parent_entity_id = params[:entity][:parent_entity_id]
    entity.anonymous = params[:entity][:anonymous]
    render :text => entity.to_yaml and return
    entity.save


    if request.xhr?
      render :partial=>"entity_reply_added", :locals => {:entity => entity}, :layout=>false and return
    else
      if entity.parent_entity.user_id!=entity.user_id then
        #SystemMailer.reply_notification(entity.parent_entity.user, entity.parent_entity).deliver
        Notification.create(:user_id=>entity.parent_entity.user_id, :entity_id=>entity.id, :read=>false)
      end
      redirect_to controller: "entitys", action: "home" and return
    end
  end

  def rate_up
    StatsMix.track("Like",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] == 'www.entitys.com'
    StatsMix.track("Like staging",1,{:meta=>{"layout"=>get_current_layout}}) if ENV["entityS_HOST"] != 'www.entitys.com' and Rails.env!="test"
    f = entitysRating.create(:user_id => current_user.id, :entity_id => @entity.id)
    render :text=>f.errors.blank? ? [@entity.id,@entity.entitys_ratings.all.size] : f.errors.messages.values.flatten.join("<br/>") and return
  end

  def load_comments
    type = params[:type]
    page = params[:page]
    entity = entity.find params[:id]
    replies = entity.replies.order(:id).page(page).per(20)
    if !type.nil? then
      notifications = User.find(current_user.id).notifications.find(:all, :limit=>20, :conditions => {read: false, entity_id: entity.replies},  :order => 'id')
      Notification.update_all({:read=>true},{:id=>notifications})
    end
    last_page = (entity.replies.count/10)*10!=entity.replies.count ? (entity.replies.count/20)+1 : entity.replies.count/20
    post_page= page==last_page.to_s ? "all_comments" : Integer(page)+1
    if(Integer(page) > 1)
      render :partial=> type.nil? ? "comments_lazy_load" : "my_comments_lazy_load",
        :locals => type.nil? ? {:entity => entity, :replies=> replies, :page=>Integer(page)+1} : {:my_entity => entity, :replies=> replies, :page=>post_page} , :layout=>false and return
    else
      render :partial=> type.nil? ? "comments_expanded" : "my_comments_expanded",
        :locals => type.nil? ? {:entity => entity, :replies=> replies, :page=>Integer(page)+1} : {:my_entity => entity, :replies=> replies, :page=>post_page}, :layout=>false and return
    end
  end

  def load_all_comments
    entity = entity.find params[:id]
    replies = entity.replies.order(:id)
    Notification.update_all({:read => true}, {:user_id => current_user.id, :entity_id=> entity.replies}) if current_user.present?
    if is_mobile_device_local? then
      render :locals => {:entity => entity, :replies=> replies}, :layout=>false and return
    else
      render :partial=> "my_comments_expanded",
        :locals => {:my_entity => entity, :replies=> replies, :page=>"all_comments"}, :layout=>false and return
    end
  end

  def collapse_comments
    type = params[:type]
    entity = entity.find params[:id]
    render :partial=> type.nil? ? "comments_collapsed" : "my_comments_collapsed", :locals => type.nil? ? {:entity => entity}: {:my_entity => entity}, :layout=>false and return
  end

  def destroy
    @entity.archive
    Notification.update_all({:read => true}, {:user_id => current_user.id, :entity_id=> @entity.replies}) if current_user.present?
    @entity.remove_from_index
    render :text => [@entity.id,@entity.archived?] and return
  end

  # may be needed some day
  def restore
    @entity.unarchive
    @entity.index
    render :text => [@entity.id,@entity.archived?] and return
  end

  def update
    @entity.update_attribute("body", params[:entity][:body])
    redirect_to controller: "entitys", action: "home" and return
  end

  def home
    if current_user.present? and session[:firstTimeInentitys]==nil then
      if current_user.sign_in_count==1
        @firstTime = true
        session[:firstTimeInentitys] = "no"
      end
    else
      @firstTime = false
    end
    if current_user.present? and cookies[:login_from_post_mobile]=="true"
      cookies.delete :login_from_post_mobile
      redirect_to controller: "entitys", action: "new"
    end
    #    @share = {"twitter" => true,"facebook" => true, "id" => 111}
    @entitys = entity.where("parent_entity_id is NULL AND archived_at is NULL").includes(:user, :entitys_ratings).order("created_at desc").page(params[:page]).per(is_mobile_device_local? ? 10 : 20)
    # @tags = entity.tag_counts.includes(:taggings).group("tag_id").having("COUNT(taggings.tag_id) > 5").order("name")
    @tags = entity.tag_counts.order("count DESC").limit(10)
    #@forward = "my_entitys"
    if cookies[:place_of_request].present? and current_user.present? then
      cookies[:anonymous]=="yes" ? current_user.update_attribute(:anonymous, 1) : ""
      if cookies[:place_of_request]!="post_entity" && cookies[:place_of_request]!="breakingentity" then
        params[:id]=@place_of_request
        redirect_to action: "show", id: cookies[:place_of_request]
      else
        @keeped_data=get_data_from_session
      end
    else @keeped_data= {:saved_text=>'', :twitter_state=>'', :facebook_state=>'', :saved_link=>'', :place_of_request=>''}
    end
  end

  def lazy_load
    @entitys = entity.where("parent_entity_id is NULL AND archived_at is NULL").includes(:user, :entitys_ratings).order("created_at desc").page(params[:page]).per(params[:m].present? ? 10 : 20)
    @keeped_data=get_data_from_session
    if params[:m].present?
      render :partial=> "entitys_lazy_load_mobile", :locals => {:entitys => @entitys}, :layout=>false and return
    else
      render :partial=> "entitys_lazy_load", :locals => {:entitys => @entitys}, :layout=>false and return
    end
  end

  def lazy_load_my
    @my_entitys = entity.where(["user_id = ? and parent_entity_id is NULL AND archived_at is NULL ", current_user.id]).includes(:user, :entitys_ratings).order("created_at desc").page(params[:page]).per(10)
    @last_entity = entity.where(["user_id = ? and parent_entity_id is NULL AND archived_at is NULL ", current_user.id]).includes(:user, :entitys_ratings).order("created_at desc").last
    @keeped_data=get_data_from_session
    render :partial=> "entitys_lazy_load_my_mobile", :locals => {:my_entitys => @my_entitys}, :layout=>false and return
  end

  def remove_all_notifications
    Notification.update_all({:read => true}, {:user_id => current_user.id}) if current_user
    render text: "0" and return
  end

  def notifications_count
    notifications_num = get_notifications_amount
    render text: notifications_num>5 ? '5+' : notifications_num.to_s and return
  end

  def remove_notification()
    Notification.update_all({:read => true}, {:user_id => current_user.id, :entity_id=> entity.find(params[:id]).replies}) if current_user.present?
    notifications_num = get_notifications_amount
    render text: notifications_num>5 ? '5+' : notifications_num.to_s and return
  end

  def notifications_list
    if current_user.present?
      count_of_notifications=5
      count = 0
      @notifications_data = Hash.new
      while count<count_of_notifications do
        count_before=count
        notifications = User.find(current_user.id).notifications.find(:all, :limit=>count_of_notifications, :conditions => {read: false},  :order => 'created_at DESC')
        break if notifications.blank?
        notifications.each do |notification|

          # error structure of notification
          if notification.entity.blank? or notification.entity.parent_entity.blank?
            notification.update_attributes(read: true)
            next
          end

          if @notifications_data.try(:[],notification.entity)==nil then
            @notifications_data[notification.entity] = count
            count+=1
            break if count>=count_of_notifications
          end

          entity_replies = notification.entity.parent_entity.replies

          notifications2 = User.find(current_user.id).notifications.find(:all, :limit=>"10", :conditions => {read: false, entity_id: entity_replies},  :order => 'created_at DESC')
          notifications2.each do |notification2|
            if @notifications_data.try(:[],notification2.entity)==nil then
              @notifications_data[notification2.entity] = count
              count+=1
              break if count>=count_of_notifications
            end
          end
          break if count>=count_of_notifications
        end
        break if count>=count_of_notifications or count_before==count
      end
      render :partial=> "notifications", :locals => {:entitys => @notifications_data}, :layout=>false and return
    end
  end

  def keep_post_ajax
    cookies[:saved_text] = { :value => params[:saved_text], :expires => Time.now + 600}
    cookies[:twitter_state] = { :value => params[:twitter_state], :expires => Time.now + 600}
    cookies[:facebook_state] = { :value => params[:facebook_state], :expires => Time.now + 600}
    cookies[:saved_link] = { :value => params[:saved_link], :expires => Time.now + 600}
    cookies[:place_of_request] = { :value => params[:place_of_request], :expires => Time.now + 600}
    cookies[:anonymous] = { :value => params[:anonymous], :expires => Time.now + 600}
    redirect_to action: "err404"
  end

  def check_entity_for_spam
    entity=entity.new
    entity.body=params[:entity_body]
    entity.user_id = current_user.id
    render text: 'Your entity contains spam content. Please rewrite it in another way.' and return if entity.spam?
    render text: '' and return
  end

  def test_video
    youtube_hash = youtube_embed(params[:video_link])
    if youtube_hash.present?
      begin
        youtube_video = YoutubeSearch.search(youtube_hash).first
      rescue
        render text: 'Connection error' and return
      end        
      if youtube_video.present?
        render text: 'Inappropriate videos may not be uploaded' and return if youtube_video['embeddable'] == false
        render text: 'Inappropriate videos may not be uploaded' and return if youtube_video.has_key?('racy')
        render text: '' and return
      else
        render text: 'Youtube link must be used' and return
      end
    else
      render text: 'Youtube link must be used' and return
    end
  end

  def err404
    respond_to do |format|
      format.html {
        render layout: "header"
      }
      format.mobile {
        render layout: "application"
      }
    end
  end

  def comment
    @entity = entity.find(params[:id])
    respond_to do |format|
      format.html {
        render :layout => "application" and return
      }
      format.mobile {
        render :layout => "application" and return
      }
    end
  end

  def change_layout
    if is_mobile_device?
      session[:mobile_view]= session[:mobile_view]==true ? false : true
      redirect_to root_path
    else
      redirect_to action: "err404"
    end
  end

  private

  def get_notifications_amount
    notifications_num = current_user.present? ? User.find(current_user.id).notifications.calculate(:count, :all, :conditions => {read: false}) : 0
  end

  def get_data_from_session
    @keeped_data=Hash.new
    @keeped_data[:saved_text] = cookies[:saved_text]
    @keeped_data[:twitter_state] = cookies[:twitter_state]
    @keeped_data[:facebook_state]  = cookies[:facebook_state]
    @keeped_data[:saved_link]  = cookies[:saved_link]
    @keeped_data[:place_of_request]  = cookies[:place_of_request]
    cookies.delete :saved_text
    cookies.delete :twitter_state
    cookies.delete :facebook_state
    cookies.delete :saved_link
    cookies.delete :place_of_request
    @keeped_data
  end

  def get_entity
    @entity = entity.where(['id = ?', params[:id]]).first if params[:id].present?
    redirect_to controller: "entitys", action: "err404" and return if @entity.blank?
  end

  def get_breakingentitys
    @breakingentitys = Breakingentity.where("order_number > 0").order("order_number ASC")
  end

  def user_logged_in
    if current_user.blank?
      if request.original_fullpath()=="/entitys/new" and is_mobile_device_local?
        cookies[:login_from_post_mobile]=true
        redirect_to new_user_session_path, :flash=>{:from=>"post"} and return if is_mobile_device_local?
      end
      render :text => "Please Login first.", :status=>403 and return if request.xhr?
      redirect_to new_user_session_path and return if is_mobile_device_local?
      redirect_to controller: "entitys", action: "home" and return if @entity.blank?
    end
  end

  def verfiy_action
    render :text => "You are not allowed for this action." and return if (current_user.id != @entity.user_id) or @entity.parent_entity_id.present?
  end

  def youtube_embed(youtube_url)
    if youtube_url.present?
      if youtube_url[/youtu\.be\/([^\?]*)/]
        #youtube_id = $1
        youtube_id = youtube_url
      else
        youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
        youtube_id = $5
        youtube_id.slice!(0) if youtube_id.present? and youtube_id[0].chr == '-'
      end
    end

    youtube_id
  end

end
