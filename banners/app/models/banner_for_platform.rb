class BannerForPlatform < ActiveRecord::Base
  belongs_to :banner
  belongs_to :platform
  attr_accessible :amount_clicks, :amount_views, :default, :max_views, :banner_id, :platform_id
end
