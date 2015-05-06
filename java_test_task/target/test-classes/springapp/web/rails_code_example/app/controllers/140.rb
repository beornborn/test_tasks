class ApplicationController < ActionController::Base
  has_mobile_fu
  layout :layout_by_resource
  before_filter :ensure_proper_protocol
  before_filter :login_to_ssl_aa
  before_filter :get_backgrounds
  before_filter :set_current_user
 
  #  before_filter :fix_protocol

  protect_from_forgery
  USERS = { "entitys" => "entitys" }

  before_filter :authenticate
  
#  rescue_from Exception, :with => :render_all_errors
#  rescue_from ActiveRecord::RecordNotFound, :with => :render_all_errors
#  rescue_from ActionController::RoutingError, :with => :render_all_errors
#  rescue_from ActionController::UnknownController, :with => :render_all_errors
#  rescue_from ActionController::UnknownAction, :with => :render_all_errors
    
#  def is_mobile_device_local?
#    false
#  end

  def set_current_user
    User.current_user_for_model = current_user.blank? ?  nil : current_user
  end
  
  def get_backgrounds
    @sponsor_backgrounds = Background.find(:all, :conditions => { :active => true }, :order => "counter ASC")
  end
  
  def helpers
    Helper.new
  end

  class Helper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::SanitizeHelper
  end
  
  def fix_protocol

    puts request.url
    if !request.url.start_with? "www"
      redirect_to "www." + request.url, :status => 302 and return
    end
  end

  def layout_by_resource
    if devise_controller?
      "blank"
    else
      "application"
    end
  end

  def authenticate
    return true
    return true if ENV["APP_INFORMATION_BASE"] == "Staging"
    authenticate_or_request_with_http_digest("Application") do |name|
      USERS[name]
    end
  end
  
  def get_categories
    @categories = Category.find(:all, :order => 'counter DESC')
  end
  
  def render_all_errors(e)
    redirect_to controller: "entitys", action: "err404"
  end
  
  protected

  def is_mobile_device_local?
    session[:mobile_view]==false &&  is_mobile_device? ? false : is_mobile_device?
  end

  def get_current_layout
    is_mobile_device_local? ? "mobile" : "desktop"
  end

  def ssl_allowed_action?
    (params[:controller] == 'sessions' && ['new', 'create'].include?(params[:action])) ||
      (params[:controller] == 'registrations' && ['new', 'create', 'edit', 'update'].include?(params[:action])) ||
      (params[:controller] == 'users/omniauth_callbacks') ||
      (params[:controller] == 'active_admin/devise/sessions' && ['new', 'create'].include?(params[:action]))
  end

  def ensure_proper_protocol
    if request.ssl? && !ssl_allowed_action?
      redirect_to "http://" + request.host + request.fullpath
    end
  end
  
  def login_to_ssl_aa
    redirect_to "https://" + request.host + request.fullpath if params[:controller] == 'active_admin/devise/sessions' && ['new'].include?(params[:action]) && !request.ssl? && Rails.env=='production'
  end

  def after_sign_in_path_for(resource_or_scope)
    root_url(:protocol => 'http')
  end

  def after_sign_out_path_for(resource_or_scope)
    root_url(:protocol => 'http')
  end

  def categories_list
    @categories_for_select = Category.find(:all, :order => 'tag ASC')
  end  

end
