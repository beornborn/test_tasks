class BfComment < ActiveRecord::Base
  acts_as_taggable
  acts_as_archival
  include Rakismet::Model

  belongs_to :user
  belongs_to :breakingentity
  
  validates :body, :presence=>{:message => "can't be blank"}

  attr_accessible :heading, :body, :anonymous
  rakismet_attrs :content => :body, :author => proc { user.user_name }
end
