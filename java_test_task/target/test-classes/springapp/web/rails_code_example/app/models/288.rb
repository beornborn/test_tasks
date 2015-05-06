class PollQuestion < ActiveRecord::Base
  
  validates :adress, :presence=>{:message => "can't be blank"}
  
  attr_accessible :heading, :adress
  
end
