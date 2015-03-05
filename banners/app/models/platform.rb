class Platform < ActiveRecord::Base
  has_many :banners, through: :banner_for_platforms
  has_many :banner_for_platforms, dependent: :destroy
  attr_accessible :name
end
