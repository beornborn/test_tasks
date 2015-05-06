class RegistrationsController < Devise::RegistrationsController
  force_ssl :only => [:new, :create, :edit, :update]
  
  # GET /resource/sign_up
  def new
    resource = build_resource({})
    respond_with(resource, (is_mobile_device_local? ? {:layout => "application"} : {}))
  end
  
  def create
    build_resource
      if cookies[:so_small] == "true"
        resource.errors.add(:dob, "You are not of legal age to use this site")
        session[:omniauth] = nil
        render text: resource.errors.to_json and return
      end
    if resource.save
      if ENV["entityS_HOST"] == 'www.entitys.com'
        StatsMix.track("New all user signs up",1,{:meta=>{"layout"=>get_current_layout}})
        StatsMix.track("New ordinary user signs up",1,{:meta=>{"layout"=>get_current_layout}})
      else
        StatsMix.track("New all user signs up staging",1,{:meta=>{"layout"=>get_current_layout}})
        StatsMix.track("New ordinary user signs up staging",1,{:meta=>{"layout"=>get_current_layout}})
      end  
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        #respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        render text: "saved"
      end
    else
      if resource.errors.include?(:dob) and ["You are not of legal age to use this site"]==resource.errors[:dob]
        cookies[:so_small] = { :value => "true", :expires => 1.year.from_now }
        resource.errors.clear()
        resource.errors.add(:dob, "You are not of legal age to use this site")
        session[:omniauth] = nil
        render text: resource.errors.to_json and return
      end
#      clean_up_passwords resource
#      respond_with resource
      render text: resource.errors.to_json
    end
    session[:omniauth] = nil unless @user.new_record?
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
 
#  def build_resource(*args)
#    super
#    if session[:omniauth]
#      @user.apply_omniauth(session[:omniauth])
#      @user.valid?
#    end
#  end

  protected

  def after_inactive_sign_up_path_for(resource)
    root_url(:protocol => 'http')
  end

  def after_sign_up_path_for(resource)
    root_url(:protocol => 'http')
  end

  def after_update_path_for(resource)
    edit_user_registration_url(:protocol => 'http')
  end
end