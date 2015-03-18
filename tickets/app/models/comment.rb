class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket

  validates :ticket_id, :body, presence: true
end
