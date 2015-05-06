class entitysRating < ActiveRecord::Base

  belongs_to :user
  belongs_to :entity

  validate :already_voted

  def already_voted
    errors.add :voted, "Already Voted" if entitysRating.where({user_id: self.user_id, entity_id: self.entity_id}).first.present?
  end

end
