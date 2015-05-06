class Notification < ActiveRecord::Base

  belongs_to :user
  belongs_to :entity
  
  attr_accessible :read, :user_id, :entity_id, :created_at

end
