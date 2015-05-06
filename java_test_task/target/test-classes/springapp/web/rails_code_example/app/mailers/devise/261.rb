class Devise::Mailer < ::ActionMailer::Base
  include Devise::Mailers::Helpers

  def confirmation_instructions(record)
    logo = File.read(Rails.root.join('app/assets/images/logo.png'))
#    fb_y = File.read(Rails.root.join('app/assets/images/fancybox/y.png'))
#    fb_x = File.read(Rails.root.join('app/assets/images/fancybox/x.png'))
    attachments.inline['logo.png'] = logo
#    attachments.inline['fb_y.png'] = fb_y
#    attachments.inline['fb_x.png'] = fb_x
    devise_mail(record, :confirmation_instructions)
  end

  def reset_password_instructions(record)
    logo = File.read(Rails.root.join('app/assets/images/logo.png'))
#    fb_y = File.read(Rails.root.join('app/assets/images/fancybox/y.png'))
#    fb_x = File.read(Rails.root.join('app/assets/images/fancybox/x.png'))
    attachments.inline['logo.png'] = logo
#    attachments.inline['fb_y.png'] = fb_y
#    attachments.inline['fb_x.png'] = fb_x
    devise_mail(record, :reset_password_instructions)
  end

  def unlock_instructions(record)
    devise_mail(record, :unlock_instructions)
  end
end
