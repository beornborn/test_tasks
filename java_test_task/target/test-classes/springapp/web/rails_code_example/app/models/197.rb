class ContactUs < ActiveRecord::Base
  acts_as_textcaptcha :api_key     => ENV["TEXT_CAPTCHA_API_KEY"] || '3lzzu0l7kuo0ckwk0048s44ckatswyy8',
                      :bcrypt_salt => ENV["TEXT_CAPTCHA_BCRYPT_SALT"] || '$2a$10$9q/gqqFuCPgx42vxMp9XL.'
  
  validates :name, :presence=>{:message => "can't be blank"}
  validates :email, :presence=>{:message => "can't be blank"}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :subject, :presence=>{:message => "can't be blank"}
  validates :message, :presence=>{:message => "can't be blank"}
  
  attr_accessible :name, :email, :subject, :message

end
