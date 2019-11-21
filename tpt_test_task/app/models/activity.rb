class Activity < ApplicationRecord
  attr_accessor :should_update_colors

  validates :description, presence: true, length: { maximum: 200 }
  validates :start, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1440 }

  validate :start_cannot_be_in_future

  belongs_to :user

  before_create :set_color
  after_save :update_colors, if: :should_update_colors

  private

  def start_cannot_be_in_future
    if start.present? && start > Date.today
      errors.add(:start, "can't be in future")
    end
  end

  def set_color
    limit = self.user.working_minutes || 0
    minutes_this_day = self.user.activities.where(start: self.start).pluck(:duration).sum
    self.color = limit - minutes_this_day - self.duration >= 0 ? 'green' : 'red'
  end

  def update_colors
    limit = self.user.working_minutes || 0
    daily_activities = self.user.activities.where(start: self.start).order(id: :asc)
    used_limit = 0
    daily_activities.each do |a|
      used_limit += a.duration
      new_color = used_limit <= limit ? 'green' : 'red'
      a.update!(color: new_color)
    end
  end
end
