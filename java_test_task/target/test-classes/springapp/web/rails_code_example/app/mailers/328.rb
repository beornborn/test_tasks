class SystemMailer < ActionMailer::Base
  default :from => "entitys <support@entitys.com>"

  def contact_us(contact_us)
    @contact_us = contact_us
    email_receiver = Rails.env == "production" ? APP_CONFIG["support_mail"] : TEST_EMAIL
    mail(:from=> contact_us.email, :to => email_receiver, :subject => "Contact Us")
    #    mail( :to => "rails.rescue@gmail.com", :subject => "Contact Us")
  end

  def reply_notification(user, entity, token, type)
    @user = user
    @entity = entity
    @token = token
    @type = type
    email_receiver = Rails.env == "production" ? @user.email : TEST_EMAIL
    logo = File.read(Rails.root.join('app/assets/images/logo.png'))
#    fb_y = File.read(Rails.root.join('app/assets/images/fancybox/y.png'))
#    fb_x = File.read(Rails.root.join('app/assets/images/fancybox/x.png'))
    attachments.inline['logo.png'] = logo
#    attachments.inline['fb_y.png'] = fb_y
#    attachments.inline['fb_x.png'] = fb_x
    mail(:from => "entitys <"+APP_CONFIG["notification_mail"]+">", :to => email_receiver, :subject => "Someone replied to your entitys Post")
  end
  
  def following_notification(user, entity, token, type)
    @user = user
    @entity = entity
    @token = token
    @type = type
    email_receiver = Rails.env == "production" ? @user.email : TEST_EMAIL
    logo = File.read(Rails.root.join('app/assets/images/logo.png'))
#    fb_y = File.read(Rails.root.join('app/assets/images/fancybox/y.png'))
#    fb_x = File.read(Rails.root.join('app/assets/images/fancybox/x.png'))
    attachments.inline['logo.png'] = logo
#    attachments.inline['fb_y.png'] = fb_y
#    attachments.inline['fb_x.png'] = fb_x
    mail(:from => "entitys <"+APP_CONFIG["notification_mail"]+">", :to => email_receiver, :subject => "Someone you follow posted a message on entitys")
  end
end


#Body: (First Name), someone has replied to a post you created.  Click on the below link to view your post or log into entitys (make it link to homepage) and click on your username.
