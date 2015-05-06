class BreakingentitysRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :breakingentity

  validate :already_voted

  def already_voted
    errors.add :voted, "Already Voted" if BreakingentitysRating.where({user_id: self.user_id, breakingentity_id: self.breakingentity_id}).first.present?
  end
end
