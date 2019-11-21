class User < ApplicationRecord
  rolify
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true
  validates :working_minutes, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  has_many :activities, dependent: :destroy

  after_update :request_activities_color_update

  def request_activities_color_update
    a = self.activities.to_a
    a.map(&:start).uniq.each do |date|
      a.select {|x| x.start == date }.first.send(:update_colors)
    end
  end
end
