class Banner < ActiveRecord::Base
  has_many :platforms, through: :banner_for_platforms
  has_many :banner_for_platforms, dependent: :destroy
  attr_accessible :image, :name
  mount_uploader :image, ImageUploader
end
