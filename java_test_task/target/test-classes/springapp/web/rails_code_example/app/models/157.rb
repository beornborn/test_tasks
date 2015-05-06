require 'carrierwave/orm/activerecord'
class Background < ActiveRecord::Base
  # uploaders
  mount_uploader :resolution1366x768, BackgroundUploader
  mount_uploader :resolution1280x1024, BackgroundUploader
  mount_uploader :resolution1440x900, BackgroundUploader
  mount_uploader :resolution1920x1080, BackgroundUploader
  mount_uploader :resolution1024x768, BackgroundUploader
  mount_uploader :resolution1600x900, BackgroundUploader
  mount_uploader :resolution2560x1440, BackgroundUploader
  mount_uploader :resolution1280x800, BackgroundUploader
  mount_uploader :resolution1152x864, BackgroundUploader
  mount_uploader :resolution2560x1920, BackgroundUploader

  attr_accessible   :url, :resolution1366x768,:resolution1280x1024,
    :resolution1440x900,:resolution1920x1080,:resolution1024x768,
    :resolution1600x900,:resolution2560x1440,:resolution2560x1920,:resolution1280x800,:resolution1152x864, :counter, :active
  # validators
  validates :counter, :presence => true, :valide_counter => true
  validate :url_fix, :on => :create
  validate :url_fix, :on => :update

   def url_fix
    self.url = "http://"+self.url if self.url.present? and self.url.scan(/(http:\/\/)+/i)==[]
  end
  
end
